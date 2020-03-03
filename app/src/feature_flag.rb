class FeatureFlag
  def self.is_on? (identifier)
    check_exist identifier
    state = FeatureFlagState.find_by(identifier: identifier)
    return false unless state.present?
    state.activated
  end

  def self.is_off? (identifier)
    check_exist identifier
    state = FeatureFlagState.find_by(identifier: identifier)
    return true unless state.present?
    !state.activated
  end

  def self.check_exist(identifier)
    @index ||= YAML.load_file(FeatureFlagConstants::FEATURE_FLAG_DEFINITION_PATH)
    return if @index.map {|_,v| v}.flatten.map {|toggle| toggle['identifier']}.include? identifier.to_s
    raise "Cannot find '#{identifier}' FeatureFlag Identifier. Ensure its in the index YML"
  end
end