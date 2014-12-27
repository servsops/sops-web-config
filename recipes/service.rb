
service = node["web-config"]["service"]

service service.name do
  supports :status => true, :restart => true, :reload => true
  action service.action.to_sym
end
