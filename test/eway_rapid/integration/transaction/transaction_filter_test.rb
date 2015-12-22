require_relative '../../../test_base'

class TransactionFilterTest < TestBase
  def setup
    @client = IntegrationTest.get_sandbox_client
  end

  def test_valid_input
    @transaction = EwayRapid::InputModelFactory.create_transaction
    c = EwayRapid::InputModelFactory.create_customer
    a = EwayRapid::InputModelFactory.create_address
    p = EwayRapid::InputModelFactory.create_payment_details
    cd = EwayRapid::InputModelFactory.create_card_detail('12', '24')
    c.card_details = cd
    c.address = a
    @transaction.customer = c
    @transaction.payment_details = p
    trans_response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction)
    assert(trans_response.transaction_status.status)
    assert_not_equal(0, trans_response.transaction_status.transaction_id)

    filter = EwayRapid::Enums::TransactionFilter.new
    filter.transaction_id = trans_response.transaction_status.transaction_id

    res = @client.query_transaction_by_filter(filter)
    assert(res.transaction_status.status)
    assert_equal(trans_response.transaction_status.transaction_id, res.transaction_status.transaction_id)
  end

  def test_blank_input
    filter = EwayRapid::Enums::TransactionFilter.new
    res = @client.query_transaction_by_filter(filter)
    assert_nil(res.transaction)
  end

  def test_invalid_input
    filter = EwayRapid::Enums::TransactionFilter.new
    filter.transaction_id = 11742962
    filter.invoice_number = 'Inv 21540'
    res = @client.query_transaction_by_filter(filter)
    assert(res.errors.include? 'S9991')
  end

  def test_search_invoice_number_or_reference
    @transaction = EwayRapid::InputModelFactory.create_transaction
    c = EwayRapid::InputModelFactory.create_customer
    a = EwayRapid::InputModelFactory.create_address
    invoice_num = EwayRapid::InputModelFactory.random_string(10)
    invoice_ref = EwayRapid::InputModelFactory.random_string(10)
    p = EwayRapid::InputModelFactory.create_payment_details_with(invoice_num, invoice_ref)
    cd = EwayRapid::InputModelFactory.create_card_detail('12', '24')
    c.card_details = cd
    c.address = a
    @transaction.customer = c
    @transaction.payment_details = p
    trans_response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction)
    assert(trans_response.transaction_status.status)
    transaction_id = trans_response.transaction_status.transaction_id

    # search invoice number
    filter = EwayRapid::Enums::TransactionFilter.new
    filter.invoice_number = invoice_num
    res = @client.query_transaction_by_filter(filter)
    assert(res.transaction_status.status)
    assert_equal(transaction_id, res.transaction_status.transaction_id)
    assert_equal(invoice_num, res.transaction.payment_details.invoice_number)

    # search invoice reference
    filter = EwayRapid::Enums::TransactionFilter.new
    filter.invoice_reference = invoice_ref
    res = @client.query_transaction_by_filter(filter)
    assert(res.transaction_status.status)
    assert_equal(transaction_id, res.transaction_status.transaction_id)
    assert_equal(invoice_ref, res.transaction.payment_details.invoice_reference)
  end

  def test_search_access_code
    @transaction = EwayRapid::InputModelFactory.create_transaction
    c = EwayRapid::InputModelFactory.create_customer
    a = EwayRapid::InputModelFactory.create_address
    p = EwayRapid::InputModelFactory.create_payment_details
    cd = EwayRapid::InputModelFactory.create_card_detail('12', '24')
    c.card_details = cd
    c.address = a
    @transaction.customer = c
    @transaction.payment_details = p

    trans_response = @client.create_transaction(EwayRapid::Enums::PaymentMethod::TRANSPARENT_REDIRECT, @transaction)
    access_code = trans_response.access_code
    assert(!access_code.nil? && access_code != '')

    filter = EwayRapid::Enums::TransactionFilter.new
    filter.access_code = access_code

    res = @client.query_transaction_by_filter(filter)
    assert(res.errors.nil? || res.errors.length == 0)
  end

  def test_search_missing_invoice_number
    invoice_num = EwayRapid::InputModelFactory.random_string(100)
    filter = EwayRapid::Enums::TransactionFilter.new
    filter.invoice_number = invoice_num
    res = @client.query_transaction_by_filter(filter)
    assert(!res.errors.nil? && res.errors.length != 0)
    assert(res.errors.include? 'V6171')
  end

  def test_missing_transaction_filter_object
    invoice_num = EwayRapid::InputModelFactory.random_string(100)
    invoice_ref = EwayRapid::InputModelFactory.random_string(100)
    filter = EwayRapid::Enums::TransactionFilter.new
    filter.invoice_number = invoice_num
    filter.invoice_reference = invoice_ref
    res = @client.query_transaction_by_filter(filter)
    assert(!res.errors.nil? && res.errors.length != 0);
  end
end