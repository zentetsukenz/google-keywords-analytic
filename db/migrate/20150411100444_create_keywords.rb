class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.references :report, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :keywords, :reports
  end
end
