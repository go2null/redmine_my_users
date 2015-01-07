# This is the important line.
# It requires the file in lib/my_plugin/hooks.rb
require_dependency 'redmine_my_users/hooks'

Redmine::Plugin.register :redmine_my_users do
  name 'My Users plugin'
  description 'View users that you are sponsoring (is responsible for).'
  url 'https://github.com/go2null/redmine_my_users'

	author 'go2null'
	author_url 'https://github.com/go2null'

  version '0.1.1'
	requires_redmine :version_or_higher => '2.6.0'
end

User.send :include, UserPatch
UsersHelper.send :include, UsersHelperPatch

