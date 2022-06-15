module Fflag
  class CacheManager
    CACHE_KEY_PREFIX = 'fflag-cache'.freeze
    private_constant :CACHE_KEY_PREFIX

    DEFAULT_EXPIRES_IN = 15.minutes
    private_constant :DEFAULT_EXPIRES_IN

    def self.clear(identifier)
      return unless Fflag.configuration.cache_enable

      Rails.cache.delete(cache_key(identifier))
    end

    def self.fetch(identifier, expires_in, &blk)
      return blk.call unless Fflag.configuration.cache_enable

      Rails.cache.fetch(
        cache_key(identifier),
        expires_in: expires_in || DEFAULT_EXPIRES_IN,
        &blk
      )
    end

    def self.cache_key(identifier)
      [CACHE_KEY_PREFIX, identifier].join('-')
    end
  end
end
