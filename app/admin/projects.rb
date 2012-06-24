ActiveAdmin.register Project do
    index do
        column :title
        column :github_url
        column :description
        column :html
        column :created_at
        column :updated_at
        default_actions
    end

    form do |f|

        f.inputs do
            f.input :member_id
            f.input :github_url
            f.input :photo_url
        end

        f.globalize_inputs :project_translations do |lf|
            lf.inputs "Localisable fields" do
                lf.input :title, :as => :string
                lf.input :description, :as => :text
                lf.input :html, :as => :text

                lf.input :locale, :as => :hidden
            end
         end

        f.buttons
    end
end
