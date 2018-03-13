module SidebarHelper
  def sidebar_item_class url
    if current_page? url
      "sidebar-item active"
    else
      "sidebar-item"
    end
  end
end