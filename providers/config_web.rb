
def whyrun_supported?
  true
end

use_inline_resources

action :create do

  # TODO: handle defualt values
  site = {}
  site = new_resource.attributes

  t = template "/etc/nginx/sites-available/#{new_resource.name}" do
    mode 0644
    variables({:config => new_resource.attributes})
    source new_resource.source
    action :create
  end 

  
  link "/etc/nginx/sites-enabled/#{new_resource.name}" do
    to "/etc/nginx/sites-available/#{new_resource.name}"
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

action :remove do
  link "/etc/nginx/sites-enabled/#{new_resource.name}" do
    action :delete
    only_if "test -L /etc/nginx/sites-enabled/#{new_resource.name}"
  end
  new_resource.updated_by_last_action(true)
end
