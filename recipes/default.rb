#
# Cookbook Name:: web-config
# Recipe:: default
#

# install php5 and modules
include_recipe "web-config::_install_php"

# install php dependency manager
include_recipe "web-config::_install_php_composer"

# nginx-full 
include_recipe "web-config::_install_nginx"

# for c3.large log directory in opsworks (/mnt/)
include_recipe "web-config::_config_dirs"

include_recipe "web-config::_config_logrotate"

include_recipe "web-config::_install_scripts"

include_recipe "web-config::_config_nginx"
