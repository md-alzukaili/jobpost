class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants , :id=>false do |t|
      t.integer :id , :primary_key=>true
      t.integer :user_id
      t.integer :post_id
      t.boolean :is_seen
      t.string :attachment_url

      t.foreign_key :posts, :column => :post_id

      t.timestamps
    end
  end
end
