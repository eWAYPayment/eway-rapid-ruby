require_relative '../../../test_base'

class CancelTransactionTest < TestBase

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
    @refund = EwayRapid::Models::Refund.new
    @refund.customer = customer
  end

  def teardown

  end

  def test_valid_input
    response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction)
    refund_details = EwayRapid::InternalModels::RefundDetails.new
    refund_details.original_transaction_id = response.transaction_status.transaction_id.to_s
    @refund.refund_details = refund_details
    cancel_response = @client.cancel(@refund)
    assert(cancel_response.transaction_status.status)
  end

  def test_invalid_input1
    omit('skip flaky test')
    refund_details = EwayRapid::InternalModels::RefundDetails.new
    refund_details.original_transaction_id = 1234
    @refund.refund_details = refund_details
    cancel_response = @client.cancel(@refund)
    assert(!cancel_response.transaction_status.status)
  end

  def test_input2
    response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction)
    @transaction.auth_transaction_id = response.transaction_status.transaction_id
    auth_response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::AUTHORISATION, @transaction)
    refund_details = EwayRapid::InternalModels::RefundDetails.new
    refund_details.original_transaction_id = auth_response.transaction_status.transaction_id.to_s
    @refund.refund_details = refund_details
    cancel_response = @client.cancel(@refund)
    assert(!cancel_response.transaction_status.status)
  end
end