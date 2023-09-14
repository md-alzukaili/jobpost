class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts , :id=>false do |t|
      t.column :id, :integer, :primary_key=>true
      t.string :title
      t.string :company_name
      t.text :description
      t.integer :admin_id

      t.foreign_key :admins, :column => :admin_id

      t.timestamps
    end
  end
end
