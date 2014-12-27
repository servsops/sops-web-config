# encoding: UTF-8

#include_recipe "composer"

bash "install composer" do
  cwd "/tmp"
  code "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer"
  not_if "test -f /usr/bin/composer"
end
