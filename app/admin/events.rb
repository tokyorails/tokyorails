ActiveAdmin.register Event do
    index do
        column :name
        column :status
        column :address
        column :time
        default_actions
    end

    form do |f|

        f.inputs do
            f.input :name
            f.input :uid
            f.input :status
            f.input :address
            f.input :time
        end

        f.globalize_inputs :event_translations do |lf|
            lf.inputs "Localisable fields" do
                lf.input :html, :as => :text

                lf.input :locale, :as => :hidden
            end
         end

        f.buttons
    end
end
