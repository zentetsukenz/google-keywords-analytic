class CreateUrlTypes < ActiveRecord::Migration
  def change
    create_table :url_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
