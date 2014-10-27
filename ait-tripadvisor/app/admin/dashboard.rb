ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      #span class: "blank_slate" do
        #span I18n.t("active_admin.dashboard_welcome.welcome")
       # small I18n.t("active_admin.dashboard_welcome.call_to_action")
      #end
    end
  section "User Statistics" do
    table_for User.all do
      column :id
      column :email
      column :created_at
      column :updated_at
      #actions
    end
  end
  section "Visiting Places"
    table_for Place.all do
      column :id
      column :name
    end
   # section "Pai Graph" do
      #div do
        #render "pai_graph"
      #end
    #end
    section "Line Graph" do
      div do
        render "line_graph"
      end
    end
     # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
