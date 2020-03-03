class ToggleController < ActionController::Base
  http_basic_authenticate_with name: '', password: (ENV['FFLAG_PASSWORD'] || 'FEATUREFLAGBASIC')

  def index
    index = YAML.load_file(FeatureFlagConstants::FEATURE_FLAG_DEFINITION_PATH)
    @facade = OpenStruct.new(
        permanent_toggles: index['permanent'],
        temporary_toggles: index['temporary'],
        activated_toggles: FeatureFlagState.where(activated: true).map(&:identifier)
    )
  end

  def update
    state = FeatureFlagState.find_by(identifier: params[:identifier])
    if !state
      FeatureFlagState.create!(
          identifier: params[:identifier],
          activated: true
      )
    else
      state.update(activated: params[:toggle_on])
    end
  end
end
