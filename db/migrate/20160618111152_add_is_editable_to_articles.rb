class AddIsEditableToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_editable, :boolean, default: true
  end
end
