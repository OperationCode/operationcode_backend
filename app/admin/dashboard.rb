ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "New User Counts" do
          para "Today: #{User.count_created_since(Date.today)}"
          para "In the last week: #{User.count_created_since(1.week.ago)}"
          para "In the last month: #{User.count_created_since(1.month.ago)}"
          para "In the last year: #{User.count_created_since(1.year.ago)}"
        end
      end

      column do
        panel "Verified Users" do
          para User.verified.count
        end
      end
    end
  end
end
