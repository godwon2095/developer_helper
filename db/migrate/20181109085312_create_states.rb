class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.references :city, foreign_key: true
      t.string :state_name

      t.timestamps
    end
  end
end
