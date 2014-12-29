default.web_config = {
  "log_path" => "/var/log",
  "modules" => "php5-cli php5-dev php5-fpm php5-memcached php5-memcache php5-redis",
  "logrotate" => false
}

default.web_config.web_servers = {
  "default" => {
    "enabled" => false,
    "listen" => 80,
    "root" => "/var/www/nginx-default",
    "access_log" => "/var/log/nginx/localhost.access.log",
    "error_log" => "/var/log/nginx/localhost.error.log"
  }
}

default.web_config.service = {
  "name" => "nginx",
  "action" => "start"
}

default.web_config.app_servers = {}
