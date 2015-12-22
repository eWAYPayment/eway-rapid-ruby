require_relative '../test_base'
class RapidClientTest < TestBase

  def test_valid_rapid_client_input_param
    api_key = 'skjskj'
    password = 'uncover'
    endpoint = 'https://api.sandbox.ewaypayments.com/'

    client = EwayRapid::RapidClient.new(api_key, password, endpoint)
    errors = client.get_errors

    assert(client.get_valid?)
    assert_equal(errors.length, 0)
  end

  def test_invalid_rapid_endpoint
    api_key = 'skjskj'
    password = 'uncover'
    endpoint = ''

    client = EwayRapid::RapidClient.new(api_key, password, endpoint)
    errors = client.get_errors

    assert(!client.get_valid?)
    assert_equal(errors.length, 1)
    assert_equal(errors[0], EwayRapid::Constants::LIBRARY_NOT_HAVE_ENDPOINT_ERROR_CODE)
  end

  def test_missing_api_key_or_password
    api_key = 'skjskj'
    password = ''
    endpoint = 'http://'

    client = EwayRapid::RapidClient.new(api_key, password, endpoint)
    errors = client.get_errors

    assert(!client.get_valid?)
    assert_equal(errors.length, 1)
    assert_equal(errors[0], EwayRapid::Constants::API_KEY_INVALID_ERROR_CODE)
  end

  def test_missing_api_key_and_rapid_endpoint
    api_key = 'skjskj'
    password = ''
    endpoint = ''

    client = EwayRapid::RapidClient.new(api_key, password, endpoint)
    errors = client.get_errors

    assert(!client.get_valid?)
    assert_equal(errors.length, 2)
    assert(errors.include?EwayRapid::Constants::LIBRARY_NOT_HAVE_ENDPOINT_ERROR_CODE)
    assert(errors.include?EwayRapid::Constants::API_KEY_INVALID_ERROR_CODE)
  end

  def test_invalid_set_credential
    api_key = 'skjskj'
    password = 'uncover'
    endpoint = 'https://api.sandbox.ewaypayments.com/'

    client = EwayRapid::RapidClient.new(api_key, password, endpoint)
    assert(client.get_valid?)

    api_key = ''
    password = 'uncover'

    client.set_credentials(api_key, password)
    errors = client.get_errors
    assert(!client.get_valid?)
    assert_equal(errors.length, 1)
    assert(errors.include?EwayRapid::Constants::API_KEY_INVALID_ERROR_CODE)
  end

  def test_invalid_when_install_client_but_valid_set_credential
    api_key = 'skjskj'
    password = ''
    endpoint = 'https://api.sandbox.ewaypayments.com/'

    client = EwayRapid::RapidClient.new(api_key, password, endpoint)
    errors = client.get_errors
    assert(!client.get_valid?)
    assert_equal(errors.length, 1)

    api_key = 'skjskj'
    password = 'uncover'
    client.set_credentials(api_key, password)
    errors = client.get_errors
    assert(client.get_valid?)
    assert_equal(errors.length, 0)
  end

  def test_init_client_with_rapid_enpoin_is_sandbox_or_production
    api_key = 'skjskj'
    password = 'jjhhjk'
    endpoint = 'sandbox'

    client = EwayRapid::RapidClient.new(api_key, password, endpoint)
    web_url = client.instance_variable_get('@web_url')

    property_array = YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'eway_rapid', 'resources', 'rapid-api.yml'))
    property_array.each do |h|
      if EwayRapid::Constants::GLOBAL_RAPID_SANDBOX_REST_URL_PARAM.casecmp(h.keys.first).zero?
        assert(web_url.casecmp(h[h.keys.first]).zero?)
      end
    end
  end

  def test_find_error_code
    error_code = 'S9991'
    assert_equal('Library does not have PublicAPI key initialised, or Key is Invalid', EwayRapid::RapidClient.user_display_message(error_code))
  end
end