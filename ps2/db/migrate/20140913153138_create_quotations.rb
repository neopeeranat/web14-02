class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.text :quote
      t.string :author_name
      t.references :category, index: true

      t.timestamps
    end
  end
end
