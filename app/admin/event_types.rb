ActiveAdmin.register EventType do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  permit_params :name, :description, :recipients, :program, :goal, :duration, :faq,
    :materials, :elevator_pitch, :include_in_catalog, :learnings, :takeaways, :tag_name,
    :csd_eligible, :subtitle, :cancellation_policy, :is_kleer_certification, trainers: [:id]

  index do
    selectable_column
    column :name
    column :subtitle
  end


  form title: 'Tipos de Evento' do |f|

    tabs do
      tab 'Básico' do
        f.inputs 'Descripción' do
          f.input :name
          f.input :subtitle
          f.input :elevator_pitch
          f.input :description
        end
      end

      tab 'Detalles' do
        f.inputs 'Detalles' do
          f.input :duration
          f.input :csd_eligible
          f.input :is_kleer_certification
          f.input :trainers, :as => :check_boxes
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
