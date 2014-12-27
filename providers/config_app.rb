
def whyrun_supported?
  true
end

use_inline_resources

action :create do
  app = { :pm => {} }
  app[:name] = new_resource.name
  app[:listen] = new_resource.app[:listen]
  app[:slowlog] = new_resource.app[:slowlog]
  app[:memory_limit] = new_resource.app[:memory_limit] || "128M"

  if new_resource.app[:pm]
    app[:pm][:max_children] = new_resource.app[:pm][:max_children] || 5
    app[:pm][:start_servers] = new_resource.app[:pm][:start_servers] || 2
    app[:pm][:min_spare_servers] = new_resource.app[:pm][:min_spare_servers] || 1
    app[:pm][:max_spare_servers] = new_resource.app[:pm][:max_spare_servers] || 3
    app[:pm][:max_requests] = new_resource.app[:pm][:max_requests] || 500
  else
    app[:pm] = {
      :max_children => 5,
      :start_servers => 2,
      :min_spare_servers => 1,
      :max_spare_servers => 3,
      :max_requests => 500
    }
  end

  t = template "/etc/php5/fpm/pool.d/#{new_resource.name}.conf" do
    mode 0644
    owner "root"
    group "root"
    variables({ :app => app })
    source new_resource.source
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

action :remove do
  file "/etc/php5/fpm/pool.d/#{new_resource.name}.conf" do
    action :delete
  end
  new_resource.updated_by_last_action(true)
end
