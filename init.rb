# This is the important line.
# It requires the file in lib/my_plugin/hooks.rb
require_dependency 'redmine_my_users/hooks'

Redmine::Plugin.register :redmine_my_users do
  name 'My Users plugin'
  description 'View users that you are sponsoring (is responsible for).'
  url 'https://github.com/go2null/redmine_my_users'

	author 'go2null'
	author_url 'https://github.com/go2null'

  version '0.1.2'
	requires_redmine :version_or_higher => '2.6.0'
end



# As per http://www.redmine.org/projects/redmine/wiki/Plugin_Internals
# Due to the redmine loading lifecyle, plugin objects are loaded before
# the Redmine objects are loaded. Thus, we have to monkeypatch instead of
# merely opening up the class.
#
# Examples place these patches inside /lib but I find /app/models to be
# a more natural place for them.
#
def load_patches(path = nil)
  begin
    Project.columns
  rescue ActiveRecord::StatementInvalid => e
    # the database hasn't been populated yet,
    # we're probably undergoing a migration.
    puts "Not loading patches."
    return
  end
  directory ||= File.dirname(__FILE__)
  dir_paths = ["app/models/**", "app/helpers"]
  dir_paths.each do |path|
    Dir.glob(File.join(directory, path, '*.rb')).each do |file|
      load file
    end
  end
end
load_patches

