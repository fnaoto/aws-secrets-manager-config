# frozen_string_literal: true

require 'aws-sdk-secretsmanager'
require 'logger'

module AwsSecretsManagerConfig
  # Config for AwsSecretsManagerConfig
  class Config
    attr_accessor :logger, :secrets_manager

    def initialize
      @secrets_manager = Aws::SecretsManager::Client.new
      @logger = Logger.new($stdout)
    end
  end
end
