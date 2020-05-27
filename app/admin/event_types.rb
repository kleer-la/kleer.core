ActiveAdmin.register EventType do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  permit_params :name, :description, :recipients, :program, :goal, :duration, :faq,
    :materials, :elevator_pitch, :include_in_catalog, :learnings, :takeaways, :tag_name,
    :csd_eligible, :subtitle, :cancellation_policy, :is_kleer_certification, trainer_ids: []

  index do
    selectable_column
    column :name
    column :subtitle
    actions
  end


  form title: 'Tipos de Evento' do |f|

    tabs do
      tab 'Básico' do
        f.inputs 'Descripción' do
          f.input :name, label: "Nombre"
          f.input :subtitle, label: "Subtítulo"
          f.input :elevator_pitch
          li "No más de dos párrafos. Texto plano, <b>sin HTML ni Markdown</b>. Este texto será lo primero que se muestra en el tab de \"Descripción\", en kleer.la. También será utilizado en las Twittercards"
          f.input :description, label: "Descripción completa (Markdown)"
        end
      end

      tab 'Detalles' do
        f.inputs 'Detalles' do
          f.semantic_errors
          f.input :duration, :as => :number, label:"Duración (en horas)", :input_html => {:max => 9999}
          f.input :csd_eligible
          f.input :is_kleer_certification
          f.input :trainers, :as => :select, :input_html => {:multiple => true, :style => "height: 100px;"}
        end
      end

      tab 'Audiencia' do
        f.inputs 'Audiencia' do
          f.input :recipients
          f.input :program
          f.input :goal
          f.input :takeaways
        end
      end
    end

    actions
  end
end
