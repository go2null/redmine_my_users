class AddParentIdIndexToUsers < ActiveRecord::Migration
	def change
		add_index :users, :parent_id unless index_exists? :users, :parent_id
	end
end
