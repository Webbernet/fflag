module Fflag
  class Engine < ::Rails::Engine
  end

  class Configuration
    attr_accessor :cache_enable

    def initialize
      @cache_enable = false
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
