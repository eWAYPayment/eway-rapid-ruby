require_relative '../../../test_base'

class QueryTransactionTest < TestBase

  def setup
    @client = IntegrationTest.get_sandbox_client
  end

  def test_valid_input
    @trans = EwayRapid::InputModelFactory.create_transaction
    c = EwayRapid::InputModelFactory.create_customer
    a = EwayRapid::InputModelFactory.create_address
    p = EwayRapid::InputModelFactory.create_payment_details
    cd = EwayRapid::InputModelFactory.create_card_detail('12', '24')
    c.card_details = cd
    c.address = a
    @trans.customer = c
    @trans.payment_details = p
    trans_response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @trans)
    assert(trans_response.transaction_status.status)
    assert_not_equal(0, trans_response.transaction_status.transaction_id)

    transaction_id = trans_response.transaction_status.transaction_id
    query = @client.query_transaction_by_id(transaction_id)
    assert_equal(transaction_id, query.transaction_status.transaction_id)
    assert(query.errors.nil? || query.errors.length == 0)

    if (IntegrationTest.get_version >= 40)
      assert_not_empty(query.transaction_status.transaction_date_time)
    end

  end

  def test_blank_input
    res = @client.query_transaction_by_access_code('')
    assert_nil(res.transaction)
  end

  def test_invalid_input
    res = @client.query_transaction_by_access_code(EwayRapid::InputModelFactory.random_string(50))
    assert_nil(res.transaction)
  end

  def teardown; end
end