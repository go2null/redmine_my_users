require 'redmine'
require 'sponsor_view_application_hooks'

Redmine::Plugin.register :sponsor_view do
  name 'Sponsor View plugin'
  author 'Monica K'
  description 'A plugin that will add to "My Account" page for sponsor users.'
  version '0.0.1'
  url 'https://***/my/account'
end
