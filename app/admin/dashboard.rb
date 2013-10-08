ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    # Display recent projects in column
    columns do
       column do
         panel "Recent Projects" do
           ul do
             Project.last(5).map do |project|
               li link_to(project.title, admin_project_path(project))
             end
           end
         end
       end

       # Display some info
       column do
         panel "Info" do
           para "Welcome to ActiveAdmin."
         end
       end
    end
  end # content
end
