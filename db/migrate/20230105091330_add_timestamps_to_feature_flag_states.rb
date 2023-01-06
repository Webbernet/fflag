class AddTimestampsToFeatureFlagStates < ActiveRecord::Migration[5.2]
  def change
    add_column :feature_flag_states, :updated_at, :datetime
  end
end

