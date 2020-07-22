class CreateTiles < ActiveRecord::Migration[5.2]
  def change
    create_table :tiles, id: :uuid do |t|
      t.string :title
      t.integer :amount
      t.boolean :type
      t.boolean :sandbox
      t.date :duedate
      t.integer :trafficlight
      t.references :column, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
