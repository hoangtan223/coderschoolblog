class AddIsDeletableToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_deletable, :boolean, default: true
  end
end
