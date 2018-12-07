require_relative '../../../test_base'

class AuthorizationTransactionTest < TestBase

  def setup
    @client = IntegrationTest.get_sandbox_client
    @transaction = EwayRapid::InputModelFactory.create_transaction
    customer = EwayRapid::InputModelFactory.create_customer
    address = EwayRapid::InputModelFactory.create_address
    payment_details = EwayRapid::InputModelFactory.create_payment_details
    card_details = EwayRapid::InputModelFactory.create_card_detail('12', '24')
    customer.card_details = card_details
    customer.address = address
    @transaction.customer = customer
    @transaction.payment_details = payment_details
    @transaction.capture = false
  end

  def teardown

  end

  def test_valid_input
    response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction)
    @transaction.auth_transaction_id = response.transaction_status.transaction_id
    auth_response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::AUTHORISATION, @transaction)

    assert(response.transaction_status.status)
    assert_not_equal(0, auth_response.transaction_status.transaction_id)
  end

  def test_invalid_input1
    @transaction.auth_transaction_id = 1234
    auth_response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::AUTHORISATION, @transaction)
    assert(auth_response.errors.include?('V6134'))
  end

  def test_input2
    response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction)
    @transaction.auth_transaction_id = response.transaction_status.transaction_id
    auth_response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::AUTHORISATION, @transaction)
    @transaction.auth_transaction_id = auth_response.transaction_status.transaction_id
    auth_response2 = @client.create_transaction(EwayRapid::Enums::PaymentMethod::AUTHORISATION, @transaction)
    assert(!auth_response2.transaction_status.status)
  end
end