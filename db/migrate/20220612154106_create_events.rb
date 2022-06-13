class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.float :points
      t.float :buy_in
      t.integer :entrants
      t.date :date

      t.timestamps
    end
  end
end
