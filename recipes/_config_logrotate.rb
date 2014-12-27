# encoding: UTF-8

directory "/opt/logrotate.d" do
  owner "root"
  group "root"
  action :create
end

# scripts to run-logrotate and upload to s3

s3_bucket = node[:nxweb][:s3_bucket]

directory "/opt/scripts"

template "/opt/scripts/nx-logs-to-s3.sh" do
  mode 0755
  owner "root"
  group "root"
  variables({ :s3_bucket => s3_bucket })
  source "script-nx-logs-to-s3.sh.erb"
end

# custom logrotate configs

template "/opt/logrotate.d/php5-fpm" do
  mode 0644
  owner "root"
  group "root"
  source "logrotate.php.erb"
end

template "/opt/logrotate.d/nginx" do
  mode 0644
  owner "root"
  group "root"
  source "logrotate.nginx.erb"
end

# set cron jobs to run those scripts

job_content = "
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
SHELL=/bin/bash
13 * * * * root nice -n 10 bash /opt/scripts/nx-logs-to-s3.sh &>> /var/log/cron.log
"

job_content = "" unless node[:nxweb][:logrotate]

file "/etc/cron.d/rotate-upload-logs" do
  mode 0644
  owner "root"
  group "root"
  content job_content
end

