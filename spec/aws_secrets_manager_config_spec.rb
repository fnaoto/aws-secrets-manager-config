# frozen_string_literal: true

require 'bundler/setup'
require 'aws_secrets_manager_config'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec.describe AwsSecretsManagerConfig do
  subject(:AwsSecretsManagerConfig) { described_class }

  let(:secret_id) { 'secret' }
  let(:secrets_manager) { double }
  let(:secret_response) { OpenStruct.new(secret_string: secret_string) }

  describe 'get_json_value' do
    let(:secret_string) { '{ "value": "string" }' }

    context 'get json secret' do
      before do
        allow(described_class).to receive(:secrets_manager) { secrets_manager }
        allow(secrets_manager).to receive(:get_secret_value) { secret_response }
        AwsSecretsManagerConfig.get_json_value(secret_id: secret_id)
      end

      it 'return valid secret' do
        expect(secrets_manager).to have_received(:get_secret_value).with(secret_id: secret_id)
      end
    end
  end

  describe 'put_json_value' do
    let(:secret_string) { '{ "value": "string" }' }

    context 'put json secret' do
      before do
        allow(described_class).to receive(:secrets_manager) { secrets_manager }
        allow(secrets_manager).to receive(:put_secret_value) { secret_response }
        AwsSecretsManagerConfig.put_json_value(secret_id: secret_id, secret_string: secret_string)
      end

      it 'return valid secret' do
        expect(secrets_manager).to have_received(:put_secret_value).with(secret_id: secret_id,
                                                                         secret_string: secret_string)
      end
    end
  end
end
