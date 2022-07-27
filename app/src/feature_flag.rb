class FeatureFlag
  def self.is_on?(identifier, expires_in: nil)
    ::Fflag::CacheManager.fetch(identifier, expires_in) do
      check_exist(identifier)
      state = FeatureFlagState.find_by(identifier: identifier)
      state.present? ? state.activated : false
    end
  end

  def self.is_off?(identifier, expires_in: nil)
    !is_on?(identifier, expires_in: expires_in)
  end

  def self.check_exist(identifier)
    @index ||= YAML.load_file(FeatureFlagConstants::FEATURE_FLAG_DEFINITION_PATH)
    return if @index.map {|_,v| v}.flatten.map {|toggle| toggle['identifier']}.include? identifier.to_s

    raise RuntimeError.new("Cannot find '#{identifier}' FeatureFlag Identifier. Ensure its in the index YML")
  end
end
