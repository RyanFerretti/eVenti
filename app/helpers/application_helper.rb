module ApplicationHelper
  def body_class
    "admin" if current_admin
  end
end
