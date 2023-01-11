# typed: ignore
module Support
  module TestHelpers
    module FeatureFlagHelper
      # Add 2 helper to avoid spec breaking when new flag added
      # Before your spec:
      #    feature_flag_all =>to set all defaults flags to false(or true)
      #
      # In specific teset case:
      #   feature_flag_on(:some_flag) => to only change this flag without reset others.
      #
      def feature_flag_all(toggle: false)
        defaults.each do |feature|
          allow(FeatureFlag).to receive(:is_on?).with(feature).and_return(toggle)
          allow(FeatureFlag).to receive(:is_off?).with(feature).and_return(!toggle)
        end
      end

      def feature_flag_on(feature, allow_access: true)
        allow(FeatureFlag).to receive(:is_on?).with(feature).and_return(allow_access)
        allow(FeatureFlag).to receive(:is_off?).with(feature).and_return(!allow_access)
      end

      private

      def defaults
        @defaults ||= YAML.load_file(FeatureFlagConstants::FEATURE_FLAG_DEFINITION_PATH)
                          .values.flatten.map do |toggle|
                            toggle['identifier'].to_sym
                          end
      end
    end
  end
end
