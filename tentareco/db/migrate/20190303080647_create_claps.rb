class CreateClaps < ActiveRecord::Migration[5.2]
  def change
    create_table :claps do |t|
      t.references :user, null: false
      t.references :track, null: false

      t.timestamps
    end
  end
end
