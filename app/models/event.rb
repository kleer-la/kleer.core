# encoding: utf-8

class Event < ActiveRecord::Base
  include ActiveSupport

  self.per_page = 20

  belongs_to :country
  belongs_to :trainer
  belongs_to :trainer2, :class_name => "Trainer", :foreign_key => 'trainer2_id'
  belongs_to :trainer3, :class_name => "Trainer", :foreign_key => 'trainer3_id'
  belongs_to :event_type
  has_many :participants
  has_many :categories, :through => :event_type

  has_many :campaign_views

  scope :visible, where(:cancelled => false).where("date >= ?", DateTime.now-1)
  scope :past_visible, where(:cancelled => false).where("date <= ?", DateTime.now)
  scope :public_events,  where("visibility_type = 'pu' or visibility_type = 'co'")
  scope :public_commercial_events,  where(:visibility_type => "pu")
  scope :public_community_events,  where(:visibility_type => "co")
  scope :public_commercial_visible, self.visible.public_commercial_events
  scope :public_community_visible, self.visible.public_community_events
  scope :public_and_visible, self.visible.public_events
  scope :public_and_past_visible, self.past_visible.public_events

  after_initialize :initialize_defaults

  attr_accessor :event_type_id, :trainer_id, :trainer2_id, :trainer3_id, :country_id, :date, :finish_date, :place, :capacity, :city, :visibility_type, :list_price,
                  :eb_price, :eb_end_date, :draft, :cancelled, :registration_link, :is_sold_out, :participants,
                  :start_time, :end_time, :sepyme_enabled, :mode, :time_zone_name, :embedded_player, :twitter_embedded_search,
                  :notify_webinar_start, :webinar_started, :currency_iso_code, :address, :custom_prices_email_text, :monitor_email,
                  :specific_conditions, :should_welcome_email, :should_ask_for_referer_code,
                  :couples_eb_price, :business_price, :business_eb_price, :enterprise_6plus_price, :enterprise_11plus_price,
                  :show_pricing, :extra_script, :mailchimp_workflow, :mailchimp_workflow_call, :mailchimp_workflow_for_warmup, :mailchimp_workflow_for_warmup_call, :banner_text, :banner_type, :registration_ends,
                  :cancellation_policy, :enable_online_payment, :online_course_codename, :online_cohort_codename, :specific_subtitle

  validates :date, :place, :capacity, :city, :visibility_type, :list_price,
            :country, :trainer, :event_type, :duration, :start_time, :end_time, :address, :mode, :presence => true

  validates :capacity, :numericality => { :greater_than => 0, :message => :capacity_should_be_greater_than_0 }
  validates :duration, :numericality => { :greater_than => 0, :message => :duration_should_be_greater_than_0 }

  validates_each :eb_end_date do |record, attr, value|
      record.errors.add(attr, :eb_end_date_should_be_earlier_than_event_date) unless value.nil? || value < record.date
  end

  validates_each :eb_price do |record, attr, value|
      record.errors.add(attr, :eb_price_should_be_smaller_than_list_price) unless value.nil? || value < record.list_price
  end

  def self.discount_on_private(record, attr, value)
    if !value.nil? && (value > 0 && record.visibility_type == 'pr')
      record.errors.add(attr, :private_event_should_not_have_discounts)
    end
  end

  validates_each :couples_eb_price  do |record, attr, value|
    self.discount_on_private(record, attr, value)
  end

  validates_each :business_price  do |record, attr, value|
    self.discount_on_private(record, attr, value)
  end

  validates_each :business_eb_price  do |record, attr, value|
    self.discount_on_private(record, attr, value)
  end

  validates_each :enterprise_6plus_price  do |record, attr, value|
    self.discount_on_private(record, attr, value)
  end

  validates_each :enterprise_11plus_price  do |record, attr, value|
    self.discount_on_private(record, attr, value)
  end

  validates_each :time_zone_name do |record, attr, value|
    if record.is_webinar? && (value == "" || value.nil?)
      record.errors.add(attr, :time_zone_name_is_required_for_a_webinar)
    end
  end

  validate :mailchimp_workflow_call_cannot_be_empty_when_mailchimp_is_checked

  validate :mailchimp_workflow_for_warmup_call_cannot_be_empty_when_mailchimp_warmup_is_checked


  def mailchimp_workflow_call_cannot_be_empty_when_mailchimp_is_checked
    if mailchimp_workflow? && (mailchimp_workflow_call == "" || mailchimp_workflow_call.nil?)
      errors.add(:mailchimp_workflow_call, "can't be null or empty when Mailchimp Workflow is checked")
    end
  end

  def mailchimp_workflow_for_warmup_call_cannot_be_empty_when_mailchimp_warmup_is_checked
    if mailchimp_workflow_for_warmup && (mailchimp_workflow_for_warmup_call == "" || mailchimp_workflow_for_warmup_call.nil?)
      errors.add(:mailchimp_workflow_for_warmup_call, "can't be null or empty when Mailchimp Workflow for Warmup is checked")
    end
  end

  comma do
    self.visibility_type 'Visibilidad'
    self.id 'Event ID'
    self.event_type 'Event Type' do |ev_type| ev_type.nil? ? "" : ev_type.name end
    self.date 'Fecha de Inicio'
    self.country 'País' do |country| country.nil? ? "" : country.name end
    self.city 'Ciudad'
    self.participants 'Registrados' do |participants| participants.count end
    self.participants 'Confirmados' do |participants| participants.count > 0 ? participants.confirmed.count : 0 end
    self.capacity 'Capacidad'
  end

  BANNER_TYPE= {
    :info => "info",
    :success => "success",
    :warning => "warning",
    :danger => "danger"
  }

  def initialize_defaults
    if self.new_record?
     self.start_time ||= "9:00"
     self.end_time ||= "18:00"
     self.duration ||= 1
     self.should_welcome_email ||= true
    end
  end

  def completion
    if self.capacity > 0
      (self.participants.confirmed.count+self.participants.attended.count)*1.0/self.capacity
    else
      1.0
    end
  end

  def weeks_from(now=Date.today)
    from_date = now.beginning_of_week
    to_date = self.date.beginning_of_week

    weeks = (to_date - from_date) / 7
  end

  def human_date
    start_date = humanize_start_date
    end_date = humanize_end_date

    if event_is_within_the_same_day(start_date, end_date)
      human_date = start_date
    elsif event_is_within_the_same_month(start_date, end_date)
      human_date = merge_dates_in_same_month(start_date, end_date)
    else
      human_date = start_date + "-" + end_date
    end

    human_date
  end

  def human_finish_date
    humanize_end_date
  end

  def human_time
    from= self.start_time.strftime( "%H:%M" )
    to= self.end_time.strftime( "%H:%M" )
    if I18n.locale == :es
      "de " + from + " a " + to + " hs"
    else
      "from " + from + " to " + to + " hs"
    end
  end

  def start_webinar!
    if self.is_webinar?
      self.webinar_started = true
    end
  end

  def finished?
    timezone = TimeZone.new( self.time_zone_name ) unless self.time_zone_name.nil?

    if !timezone.nil?
      timezone_current_time = timezone.now
    else
      timezone_current_time = Time.now
    end

    (Time.parse( self.end_time.strftime("%Y/%m/%d %H:%M") ) < timezone_current_time )
  end

  def webinar_finished?
    if self.is_webinar? && self.webinar_started?
      finished?
    end
  end

  def is_community_event?
    self.visibility_type == 'co'
  end

  def is_classroom?
    self.mode == 'cl'
  end

  def is_online?
    self.mode == 'ol'
  end

  def is_blended_learning?
    self.mode == 'bl'
  end

  def is_webinar
    is_online? && is_community_event?
  end

  # backward compatibility
  def is_webinar?
    is_webinar
  end

  def trainers
    t= [trainer]
    if !trainer2.nil?
      t <<= trainer2
    end
    if !trainer3.nil?
      t <<= trainer3
    end
    t
  end

  def name
    event_type.nil? ? "" : event_type.name
  end

  def country_iso
    country.nil? ? "" : country.iso_code
  end

  def country_name
    country.nil? ? "" : country.name
  end

  def unique_name
    "#{name} - #{date.strftime("%Y-%m-%d")} - #{city}, #{country.name}"
  end

  def human_cancellation_limit_date
    humanize_date cancellation_limit_date
  end

  private

  def cancellation_limit_date
    registration_ends.nil? ? date : registration_ends
  end

  def get_event_duration
    self.duration || 1
  end

  def humanize_start_date
    humanize_date self.date
  end

  def humanize_end_date
    if !self.finish_date.nil?
      humanize_date self.finish_date
    else
      duration = get_event_duration
      humanize_date self.date+(duration-1)
    end
  end

  def humanize_date(date)
    human_date = I18n.l date, :format => :short
    if human_date[0] == "0"
      human_date = human_date[-5,5]
    end
    human_date
  end

  def event_is_within_the_same_day(start_date, end_date)
    start_date == end_date
  end

  def event_is_within_the_same_month(start_date, end_date)
    start_date[-3,3] == end_date[-3,3]
  end

  def merge_dates_in_same_month(start_date, end_date)
    start_date.split(' ')[0] + "-" + end_date.split(' ')[0] + " " + start_date[-3,3]
  end

end
