Deface::Override.new(:virtual_path => "spree/admin/shared/_configurations_menu",
                     :name => "suffrage_admin_tab",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                     :text => "<%= configurations_sidebar_menu_item Spree.t(:polls), admin_polls_path %>"
                    )
