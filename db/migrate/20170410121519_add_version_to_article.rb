class AddVersionToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :version, :integer
  end
end
