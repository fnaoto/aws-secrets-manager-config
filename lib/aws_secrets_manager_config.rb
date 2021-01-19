# frozen_string_literal: true

require 'aws-sdk-secretsmanager'
require 'multi_json'

# AwsSecretsManagerConfig is wrapper for aws secrets manager.
module AwsSecretsManagerConfig
  class << self
    def get_value(id)
      secrets_manager.get_secret_value(
        secret_id: id
      ).secret_string
    rescue StandardError => e
      logger.warn("[ERROR] Failed to get value #{id} : #{e}")
    end

    def get_json_value(secret_id)
      resp = get_value(secret_id)
      MultiJson.load(resp)
    end

    def config
      @config ||= Config.new
    end

    private

    def secrets_manager
      config.secrets_manager
    end

    def logger
      config.logger
    end
  end
end
