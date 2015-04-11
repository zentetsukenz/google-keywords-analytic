class CreateSearchResultUrls < ActiveRecord::Migration
  def change
    create_table :search_result_urls do |t|
      t.references :search_result, index: true
      t.references :url_type, index: true
      t.string :url

      t.timestamps null: false
    end
    add_foreign_key :search_result_urls, :search_results
    add_foreign_key :search_result_urls, :url_types
  end
end
