module UsersHelperPatch

	def self.included(base)
		base.send(:include, InstanceMethods)

		# Wrap the methods we are extending
		base.alias_method_chain :users_status_options_for_select, :parent_id

		# Exectue this code at the class level (not instance level)
		base.class_eval do
			unloadable # Send unloadable so it will not be unloaded in development

		end #base.class_eval

	end

	module InstanceMethods

		def users_status_options_for_select_with_parent_id(selected)
			user_count_by_status = User.where("parent_id = ?", User.current.id).group('status').count.to_hash
			options_for_select([[l(:label_all), ''],
											 ["#{l(:status_active)} (#{user_count_by_status[1].to_i})", '1'],
											 ["#{l(:status_registered)} (#{user_count_by_status[2].to_i})", '2'],
												 ["#{l(:status_locked)} (#{user_count_by_status[3].to_i})", '3']], selected.to_s)
		end

    def users_select(form, id_field, users, opts={})
      form.select(id_field,
                  users.sort_by {|u| [u.lastname, u.firstname]}
                       .map{|u| ["#{u.lastname}, #{u.firstname} --- (#{u.mail})", u.id]},
                  opts)
    end

	end

end

UsersHelper.send :include, UsersHelperPatch
