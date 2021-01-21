# frozen_string_literal: true

require 'json'
require 'aws_secrets_manager_config/config'

# AwsSecretsManagerConfig is wrapper for aws secrets manager.
module AwsSecretsManagerConfig
  class << self
    def get_json_value(secret_id:)
      options = { secret_id: secret_id }
      resp = get_secret(options)
      return resp if json?(resp)
    end

    def put_json_value(secret_id:, secret_string:)
      json?(secret_string)
      options = {
        secret_id: secret_id,
        secret_string: secret_string
      }
      put_secret(options)
    end

    def create_json_value(description:, name:, secret_string:, tags: [])
      json?(secret_string)
      options = {
        description: description,
        name: name,
        secret_string: secret_string,
        tags: tags
      }
      create_secret(options)
    end

    def delete_json_value(secret_id:, recovery_window_in_days: 30, force_delete_without_recovery: false)
      options = {
        secret_id: secret_id,
        recovery_window_in_days: recovery_window_in_days,
        force_delete_without_recovery: force_delete_without_recovery
      }
      delete_secret(options)
    end

    def config
      @config ||= Config.new
    end

    private

    def get_secret(options)
      secrets_manager.get_secret_value(options).secret_string
    rescue StandardError => e
      logger.warn("[ERROR] Failed to get value #{id} : #{e}")
    end

    def put_secret(options = {})
      secrets_manager.put_secret_value(options)
    rescue StandardError => e
      logger.warn("[ERROR] Failed to put value #{id} : #{e}")
    end

    def create_secret(options = {})
      secrets_manager.create_secret(options)
    rescue StandardError => e
      logger.warn("[ERROR] Failed to create value #{options} : #{e}")
    end

    def delete_secret(options = {})
      secrets_manager.delete_secret(options)
    rescue StandardError => e
      logger.warn("[ERROR] Failed to delete value #{options} : #{e}")
    end

    def json?(json)
      JSON.parse(json)
      true
    rescue JSON::ParserError
      false
    end

    def secrets_manager
      config.secrets_manager
    end

    def logger
      config.logger
    end
  end
end
