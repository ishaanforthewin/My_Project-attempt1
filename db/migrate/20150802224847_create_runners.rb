class CreateRunners < ActiveRecord::Migration
  def change
    create_table :runners do |t|
      t.string :name
      t.string :email
      t.string :distance
      t.integer :pace

      t.timestamps null: false
    end
  end
end
