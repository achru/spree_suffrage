Deface::Override.new(:virtual_path => "spree/admin/shared/_menu",
                     :name => "suffrage_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab(:polls, :icon => 'icon-question-sign') %>")
