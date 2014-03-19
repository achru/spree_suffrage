Deface::Override.new(:virtual_path => "spree/admin/shared/menu",
                     :name => "suffrage_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab(:polls, :icon => 'icon-question-sign') %>")
