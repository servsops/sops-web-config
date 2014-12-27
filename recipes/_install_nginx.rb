# encoding: UTF-8

package "nginx-full"


service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :disable, :start ]
end


# main config file

template "/etc/nginx/nginx.conf" do
  mode 0644
  owner "root"
  group "root"
  source "nginx.conf.erb"
  notifies :restart, "service[nginx]", :delayed
end
