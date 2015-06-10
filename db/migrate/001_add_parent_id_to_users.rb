class AddParentIdToUsers < ActiveRecord::Migration
	def change
		add_reference :users, :parent, null: true, index: true unless column_exists? :users, :parent_id
	end
end
