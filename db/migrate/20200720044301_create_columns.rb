class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns, id: :uuid do |t|
      t.string :title
      t.references :user, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
