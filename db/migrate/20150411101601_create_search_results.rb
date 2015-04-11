class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.references :keyword, index: true
      t.integer :top_ads_count
      t.integer :right_ads_count
      t.integer :total_ads_count
      t.integer :non_ads_count
      t.integer :total_link
      t.string :keyword_result
      t.text :html_code

      t.timestamps null: false
    end
    add_foreign_key :search_results, :keywords
  end
end
