require_relative '../../../test_base'

class TransparentTransactionTest < TestBase

  def setup
    @client = IntegrationTest.get_sandbox_client
    @transaction = EwayRapid::InputModelFactory.create_transaction
    c = EwayRapid::InputModelFactory.create_customer
    a = EwayRapid::InputModelFactory.create_address
    p = EwayRapid::InputModelFactory.create_payment_details
    cd = EwayRapid::InputModelFactory.create_card_detail('12', '24')
    c.card_details = cd
    c.address = a
    @transaction.customer = c
    @transaction.payment_details = p
  end

  def test_valid_input
    res = @client.create_transaction(EwayRapid::Enums::PaymentMethod::TRANSPARENT_REDIRECT, @transaction)
    assert_not_nil(res.form_action_url)
  end

  def test_blank_input
    tran = EwayRapid::Models::Transaction.new
    c = EwayRapid::Models::Customer.new
    cd = EwayRapid::Models::CardDetails.new
    c.card_details = cd
    tran.customer = c
    tran.transaction_type = EwayRapid::Enums::TransactionType::PURCHASE
    res = @client.create_transaction(EwayRapid::Enums::PaymentMethod::TRANSPARENT_REDIRECT, tran)
    assert(res.errors.include? 'V6047')
  end
end