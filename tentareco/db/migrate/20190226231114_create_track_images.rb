class CreateTrackImages < ActiveRecord::Migration[5.2]
  def change
    create_table :track_images do |t|
      t.references :track
      t.string :alt_text, null: false, default: ""
      
      t.timestamps
    end
  end
end
