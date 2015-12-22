require_relative '../../../test_base'

class CustomerTest < TestBase

  def setup
    @customer = EwayRapid::InputModelFactory.create_customer
    @address = EwayRapid::InputModelFactory.create_address
  end

  def teardown

  end

  def test_create_customer_direct
    customer = get_customer_direct(@customer, @address)
    assert_equal(@customer.first_name, customer.first_name)
  end

  def test_create_customer_direct_but_auth_failure
    client = EwayRapid::RapidClient.new(IntegrationTest::API_KEY, 'ABCXYZ', IntegrationTest::SANDBOX_ENDPOINT)
    card_details = EwayRapid::InputModelFactory.create_card_detail('12', '25')
    @customer.card_details = card_details
    @customer.address = @address

    response = client.create_customer(EwayRapid::Enums::PaymentMethod::DIRECT, @customer)
    errors = response.errors
    assert(errors.length != 0)
    assert_equal(1, errors.length)
    assert(errors.include? (EwayRapid::Constants::AUTHENTICATION_FAILURE_ERROR_CODE))
  end

  def test_create_customer_direct_but_wrong_endpoint
    invalid_endpoint = 'https://api.sandbox.ewaypayments.com/'
    client = EwayRapid::RapidClient.new(IntegrationTest::API_KEY, 'ABCXYZ', invalid_endpoint)
    fake_web_url = 'https://hhhhhhh.ggg/'
    client.instance_variable_set('@rapid_endpoint', fake_web_url)

    card_details = EwayRapid::InputModelFactory.create_card_detail('12', '25')
    @customer.card_details = card_details
    @customer.address = @address

    response = client.create_customer(EwayRapid::Enums::PaymentMethod::DIRECT, @customer)
    errors = response.errors
    assert(errors.length != 0)
    assert_equal(1, errors.length)
    assert(response.errors.include?(EwayRapid::Constants::COMMUNICATION_FAILURE_ERROR_CODE))
  end

  def test_create_customer_invalid_payment_method
    response = IntegrationTest.get_sandbox_client.create_customer(EwayRapid::Enums::PaymentMethod::WALLET, @customer)
    errors = response.errors
    assert(errors.length != 0)
    assert_equal(1, errors.length)
    assert(response.errors.include?(EwayRapid::Constants::INTERNAL_RAPID_API_ERROR_CODE))
  end

  def test_create_customer_with_blank_input
    address = EwayRapid::Models::Address.new
    @customer.address = address

    card_details = EwayRapid::Models::CardDetails.new
    @customer.card_details = card_details

    response = IntegrationTest.get_sandbox_client.create_customer(EwayRapid::Enums::PaymentMethod::DIRECT, @customer)
    errors = response.errors
    assert(errors.length != 0)
    assert(response.errors.include?('V6021'))
    assert(response.errors.include?('V6022'))
    assert(response.errors.include?('V6101'))
    assert(response.errors.include?('V6102'))
  end

  def test_query_direct_valid_customer_id
    @customer.address = @address
    card_details = EwayRapid::InputModelFactory.create_card_detail('12', '25')
    @customer.card_details = card_details
    response = IntegrationTest.get_sandbox_client.create_customer(EwayRapid::Enums::PaymentMethod::DIRECT, @customer)

    token_customer_id = response.customer.token_customer_id
    assert_not_nil(token_customer_id)

    token_id = Integer(token_customer_id)
    cust_response = IntegrationTest.get_sandbox_client.query_customer(token_id)
    errors = cust_response.errors
    assert(errors.nil? || errors.length == 0)
  end

  def test_create_customer_with_response_shared
    @customer.address = @address
    card_details = EwayRapid::InputModelFactory.create_card_detail('12', '25')
    @customer.card_details = card_details

    response = IntegrationTest.get_sandbox_client.create_customer(EwayRapid::Enums::PaymentMethod::RESPONSIVE_SHARED, @customer)
    assert(!response.shared_payment_url.empty?)
  end

  def test_create_customer_with_transparent_redirect
    @customer.address = @address
    card_details = EwayRapid::InputModelFactory.create_card_detail('12', '25')
    @customer.card_details = card_details

    response = IntegrationTest.get_sandbox_client.create_customer(EwayRapid::Enums::PaymentMethod::TRANSPARENT_REDIRECT, @customer)
    assert(!response.form_action_url.empty?)
  end

  def test_update_customer_direct
    customer = get_customer_direct(@customer, @address)
    customer.first_name = 'Steve'
    customer.last_name = 'Christian'
    card_details = EwayRapid::InputModelFactory.create_card_detail('12', '25')
    customer.card_details = card_details

    response = IntegrationTest.get_sandbox_client.update_customer(EwayRapid::Enums::PaymentMethod::DIRECT, customer)
    assert('Steve'.casecmp(response.customer.first_name) == 0)
    assert('Christian'.casecmp(response.customer.last_name) == 0)
  end

  def test_update_customer_responsive
    customer = get_customer_direct(@customer, @address)
    customer.first_name = 'Steve'
    customer.last_name = 'Christian'
    customer.redirect_url = 'http://www.eway.com.au'
    customer.cancel_url= 'http://www.eway.com.au'

    response = IntegrationTest.get_sandbox_client.update_customer(EwayRapid::Enums::PaymentMethod::RESPONSIVE_SHARED, customer)
    assert('Steve'.casecmp(response.customer.first_name) == 0)
    assert('Christian'.casecmp(response.customer.last_name) == 0)
  end

  def test_update_customer_transparent
    customer = get_customer_direct(@customer, @address)
    customer.first_name = 'Steve'
    customer.last_name = 'Christian'
    customer.redirect_url = 'http://www.eway.com.au'

    response = IntegrationTest.get_sandbox_client.update_customer(EwayRapid::Enums::PaymentMethod::TRANSPARENT_REDIRECT, customer)
    assert('Steve'.casecmp(response.customer.first_name) == 0)
    assert('Christian'.casecmp(response.customer.last_name) == 0)
  end

  def get_customer_direct(customer, address)
    card_details = EwayRapid::InputModelFactory.create_card_detail('12', '25')
    customer.card_details = card_details
    customer.address = address
    response = IntegrationTest.get_sandbox_client.create_customer(EwayRapid::Enums::PaymentMethod::DIRECT, customer)
    response.customer
  end
end