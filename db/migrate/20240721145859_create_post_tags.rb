class CreatePostTags < ActiveRecord::Migration[7.1]
  def change
    create_table :post_tags do |t|
      t.belongs_to :post, index: true, null: false
      t.belongs_to :tag, index: true, null: false
      t.timestamps
    end
  end
end
