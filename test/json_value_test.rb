# frozen_string_literal: true

require 'test_helper'
require 'aws_secrets_manager_config'

class JsonValueTest < Minitest::Test
  def setup
    @secrets = AwsSecretsManagerConfig
    @id = "id_#{rand(0..1000)}"
    @option = {
      description: 'description',
      name: @id,
      secret_string: '{ "value": "string" }',
      tags: [
        {
          key: 'key',
          value: 'value'
        }
      ]
    }
  end

  def test_get_json_value
    @secrets.create_json_value(@option)
    resp = @secrets.get_json_value(secret_id: @id)
    assert !resp.nil?
    @secrets.delete_json_value(secret_id: @id)
  end
end
