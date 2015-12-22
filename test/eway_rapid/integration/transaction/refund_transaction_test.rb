require_relative '../../../test_base'

class RefundTransactionTest < TestBase

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
    @refund = EwayRapid::Models::Refund.new
    @refund.customer = c
  end

  def test_valid_input
    res = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction);
    rd = EwayRapid::InternalModels::RefundDetails.new
    rd.original_transaction_id = res.transaction_status.transaction_id.to_s
    @refund.refund_details = rd
    @refund.customer.card_details.cvn = nil
    @refund.customer.card_details.issue_number = nil
    @refund.customer.card_details.name = nil
    @refund.customer.card_details.number = nil
    @refund.customer.card_details.start_month = nil
    @refund.customer.card_details.start_year = nil
    refund_res = @client.refund(@refund)
    assert(refund_res.transaction_status.status)
  end

  def test_invalid_input
    res = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction);
    rd = EwayRapid::InternalModels::RefundDetails.new
    rd.original_transaction_id = res.transaction_status.transaction_id.to_s
    rd.total_amount = 1001
    @refund.refund_details = rd
    @refund.customer.card_details.cvn = nil
    @refund.customer.card_details.issue_number = nil
    @refund.customer.card_details.name = nil
    @refund.customer.card_details.number = nil
    @refund.customer.card_details.start_month = nil
    @refund.customer.card_details.start_year = nil
    refund_res = @client.refund(@refund)
    assert(refund_res.errors.include? 'V6151')
  end

  def test_invalid_input_2
    res = @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction);
    rd = EwayRapid::InternalModels::RefundDetails.new
    rd.original_transaction_id = res.transaction_status.transaction_id.to_s
    @refund.refund_details = rd
    @refund.customer.card_details.cvn = nil
    @refund.customer.card_details.issue_number = nil
    @refund.customer.card_details.name = nil
    @refund.customer.card_details.number = nil
    @refund.customer.card_details.start_month = nil
    @refund.customer.card_details.start_year = nil
    refund_res = @client.refund(@refund)
    @refund.refund_details.original_transaction_id = refund_res.transaction_status.transaction_id
    refund_res2 = @client.refund(@refund)
    assert(refund_res2.errors.include? 'V6113')
  end

  def test_invalid_input_3
    @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction)
    rd = EwayRapid::InternalModels::RefundDetails.new
    rd.original_transaction_id = 'abcd'
    @refund.refund_details = rd
    @refund.customer.card_details.cvn = nil
    @refund.customer.card_details.issue_number = nil
    @refund.customer.card_details.name = nil
    @refund.customer.card_details.number = nil
    @refund.customer.card_details.start_month = nil
    @refund.customer.card_details.start_year = nil
    refund_res = @client.refund(@refund)
    assert(refund_res.errors.include? 'V6115')
  end

  def test_invalid_input_4
    @client.create_transaction(EwayRapid::Enums::PaymentMethod::DIRECT, @transaction)
    rd = EwayRapid::InternalModels::RefundDetails.new
    rd.original_transaction_id = nil
    @refund.refund_details = rd
    @refund.customer.card_details.cvn = nil
    @refund.customer.card_details.issue_number = nil
    @refund.customer.card_details.name = nil
    @refund.customer.card_details.number = nil
    @refund.customer.card_details.start_month = nil
    @refund.customer.card_details.start_year = nil
    # refund_res = @client.refund(@refund)
    # TODO assert(refund_res.errors.include? 'V6115')
  end
end