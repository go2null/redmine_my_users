module UserPatch

	def self.included(base)
		base.send(:include, InstanceMethods)

		# Wrap the methods we are extending
		#base.alias_method_chain :validate, :wrapping

		# Exectue this code at the class level (not instance level)
		base.class_eval do
			unloadable # Send unloadable so it will not be unloaded in development

			has_many   :children, class_name: 'User', foreign_key: 'parent_id'
			belongs_to :parent, class_name: 'User'

			validates_presence_of :parent

      safe_attributes 'parent_id'
		end

	end

	module InstanceMethods
	end

end

User.send :include, UserPatch
