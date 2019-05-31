class Category < ActiveRecord::Base
  has_and_belongs_to_many :event_types
  

  validates :name, :description, :codename, :tagline, :presence => true
  
  scope :visible_ones, -> {
    where(:visible => true)
  }
end
