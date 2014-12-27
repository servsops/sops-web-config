

# add some config

"log-format recursive-ip server-token-off".split(" ").each do |config|
  template "/etc/nginx/conf.d/001-#{config}.conf" do
    mode 0644
    owner "root"
    group "root"
    source "nginx-#{config}.erb"
    notifies :restart, "service[nginx]", :delayed
  end
end
