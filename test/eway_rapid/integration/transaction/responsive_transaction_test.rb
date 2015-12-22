require_relative '../../../test_base'

class ResponsiveTransactionTest < TestBase

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
    @transaction.custom_view = 'bootstrap'
    @transaction.header_text = 'My Site Header Text'
    @transaction.customer_read_only = false
    @transaction.logo_url = 'https://mysite.com/images/logo4eway.jpg'
    @transaction.verify_customer_email = false
    @transaction.verify_customer_phone = false
    @transaction.language = 'EN'
    @transaction.checkout_payment = false
  end

  def test_valid_input
    res = @client.create_transaction(EwayRapid::Enums::PaymentMethod::RESPONSIVE_SHARED, @transaction)
    assert_not_nil(res.shared_payment_url)
  end

  def test_blank_input
    tran = EwayRapid::Models::Transaction.new
    c = EwayRapid::Models::Customer.new
    cd = EwayRapid::Models::CardDetails.new
    c.card_details = cd
    tran.customer = c
    tran.transaction_type = EwayRapid::Enums::TransactionType::PURCHASE
    res = @client.create_transaction(EwayRapid::Enums::PaymentMethod::RESPONSIVE_SHARED, tran)
    assert(res.errors != nil && res.errors.length != 0)
  end

  def teardown; end
end