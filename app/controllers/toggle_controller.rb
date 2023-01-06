class ToggleController < ActionController::Base
  http_basic_authenticate_with name: '', password: (ENV['FFLAG_PASSWORD'] || 'FEATUREFLAGBASIC')

  def index
    index = YAML.load_file(FeatureFlagConstants::FEATURE_FLAG_DEFINITION_PATH)
    @facade = OpenStruct.new(
        permanent_toggles: index['permanent'],
        temporary_toggles: index['temporary'],
        activated_toggles: FeatureFlagState.where(activated: true).map(&:identifier),
        updated_timestamps: FeatureFlagState.all.map { |toggle| [toggle.identifier, toggle.updated_at] }.to_h
    )
  end

  def update
    state = FeatureFlagState.find_by(identifier: params[:identifier])
    if !state
      FeatureFlagState.create!(
          identifier: params[:identifier],
          activated: true,
          updated_at: Time.now
      )
    else
      state.update(activated: params[:toggle_on], updated_at: Time.now)
    end

    ::Fflag::CacheManager.clear(params[:identifier])
  end
end
