class CreateFftoggleState < ActiveRecord::Migration[5.1]
  def change
    create_table :feature_flag_states do |t|
      t.string :identifier, null: false, index: true
      t.boolean :activated, null: false, default: false
      t.boolean :deleted, null: false, default: false
    end
  end
end
