#
modules = node.web_config[:modules]

modules.split(" ").each do |m|
  package m

  if m == "php5-fpm"
    # change php5-fpm.conf upstart (old one have non-utf8 characters), ps: don't change this
    template "/etc/init/php5-fpm.conf" do
      mode 0644
      owner "root"
      group "root"
      source "upstart-php5-fpm.conf.erb"
    end
    service "php5-fpm" do
      supports :restart => true
      provider Chef::Provider::Service::Upstart
      action [ :enable,  :start ]
    end
  end
end
