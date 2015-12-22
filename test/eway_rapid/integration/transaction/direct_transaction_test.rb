require_relative '../../../test_base'

class DirectTransactionTest < TestBase

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
    shipping_details = EwayRapid::InputModelFactory.create_shipping_detail
    @transaction.shipping_details = shipping_details
  end

  def test_valid_input
    response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction)
    assert(response.transaction_status.status)
    assert_not_equal(0, response.transaction_status.transaction_id)
  end

  def test_blank_input
    transaction = EwayRapid::Models::Transaction.new
    customer = EwayRapid::Models::Customer.new
    card_detail = EwayRapid::Models::CardDetails.new
    customer.card_details = card_detail
    transaction.customer = customer
    transaction.transaction_type = EwayRapid::Enums::TransactionType::PURCHASE
    response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, transaction)
    assert(!response.transaction_status.status)
    assert_equal(0, response.transaction_status.transaction_id)

    assert(response.errors.include?('V6021'))
    assert(response.errors.include?('V6022'))
    assert(response.errors.include?('V6101'))
    assert(response.errors.include?('V6102'))
  end

  def teardown

  end
end