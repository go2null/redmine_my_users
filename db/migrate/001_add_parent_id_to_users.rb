class AddParentIdToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :parent, default: 1
    end
  end
end
