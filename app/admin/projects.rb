ActiveAdmin.register Project do

  controller do
    def create
      # Since Globalize3 doesn't inherently support tabbed UI locale creation/editing, clean up is required
      super do |format|
        @project.translations.each {|translation|
          translation.delete if translation.title.nil? && translation.description.nil?
        }
      end
    end
  end

  index do
    column :title
    column :github_url
    column :description
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :title
      row :github_url
      row :description
      row :team do
        ul do
          project.members.each do |member|
            li member.name
          end
        end
      end
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :github_url
      f.input :photo_url
      f.has_many :memberships do |member_f|
        member_f.inputs "Members" do
          if !member_f.object.nil?
            member_f.input :_destroy, :as => :boolean, :label => "Destroy?"
          end

          member_f.input :member
          member_f.input :leader, :as => :boolean, :label => "Project Leader?"
        end
      end
    end

    f.globalize_inputs :project_translations do |lf|
      lf.inputs "Localisable fields" do
        lf.input :title, :as => :string
        lf.input :description, :as => :text

        lf.input :locale, :as => :hidden
      end
    end

    f.actions
  end
end
