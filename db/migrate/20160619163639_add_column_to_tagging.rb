class AddColumnToTagging < ActiveRecord::Migration
  def change
  	add_column :taggings, :article_id, :integer
  	add_column :taggings, :tag_id, :integer 
  end
end
