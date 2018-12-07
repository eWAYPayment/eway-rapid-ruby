require_relative '../../../../lib/eway_rapid'
module EwayRapid
  class ObjectCreator

    def self.create_external_customer
      customer = Models::Customer.new
      customer.title = 'Mr.'
      customer.first_name = 'John'
      customer.last_name = 'Smith'
      customer.company_name = 'eWAY'
      customer.job_description = 'Ruby Developer'
      customer.phone = '0123456789'
      customer.mobile = '0123456789'
      customer.url = 'http://www.ewaypayments.com'
      customer.reference = 'A12345'
      customer.fax = '1234'
      customer.redirect_url = 'http://www.eway.com.au'
      customer.email = 'xxx@gmail.com'
      customer
    end

    def self.create_transaction
      Models::Transaction.new
    end

    def self.create_payment
      payment = InternalModels::Payment.new
      payment.total_amount = 1000
      payment.invoice_number = 'inv 4444'
      payment.invoice_description = 'Individual Invoice Description'
      payment.invoice_reference = '513456'
      payment.currency_code = 'AUD'
      payment
    end

    def self.create_payment_details
      payment_details = Models::PaymentDetails.new
      payment_details.currency_code = 'AUD'
      payment_details.invoice_description = 'Individual Invoice Description'
      payment_details.invoice_number = 'Inv 4444'
      payment_details.invoice_reference = '513456'
      payment_details.total_amount = 1000
      payment_details
    end

    def self.create_verification
      verification = InternalModels::Verification.new
      verification.address = '0'
      verification.cvn = '0'
      verification.email = '0'
      verification.mobile = '0'
      verification.phone = '0'
      verification
    end

    def self.create_card_details
      card_details = Models::CardDetails.new
      card_details.name = 'John Smith'
      card_details.number = '4444333322221111'
      card_details.expiry_month = '12'
      card_details.expiry_year = '25'
      card_details.cvn = '123'
      card_details
    end

    def self.create_secured_card_data
      'foo'
    end

    def self.create_internal_customer
      customer = InternalModels::Customer.new
      customer.token_customer_id = '123456789'
      customer.title = 'Mr.'
      customer.first_name = 'John'
      customer.last_name = 'Smith'
      customer.company_name = 'eWAY'
      customer.job_description = 'Ruby Developer'
      customer.phone = '0123456789'
      customer.mobile = '0123456789'
      customer.url = 'http://www.ewaypayments.com'
      customer.fax = '1234'
      customer.street1 = 'Level 5'
      customer.street2 = '369 Queen Street'
      customer.card_details = create_card_details
      customer
    end

    def self.create_internal_transaction
      transaction = InternalModels::Transaction.new
      transaction.beagle_score = 0.0
      transaction.transaction_status = true
      transaction.total_amount = 1000
      transaction.transaction_id = '123456'
      shipping_address = create_shipping_address
      transaction.shipping_address = shipping_address
      transaction
    end

    def self.create_shipping_address
      shipping_address = InternalModels::ShippingAddress.new
      shipping_address.city = 'Sydney'
      shipping_address.country = 'Au'
      shipping_address.postal_code = '2000'
      shipping_address.street1 = 'Level 5'
      shipping_address.street2 = '369 Queen Street'
      shipping_address.state = 'NSW'
      shipping_address
    end

    def self.create_address
      address = Models::Address.new
      address.city = 'Sydney'
      address.country = 'Au'
      address.postal_code = '2000'
      address.street1 = 'Level 5'
      address.street2 = '369 Queen Street'
      address.state = 'NSW'
      address
    end

    def self.create_shipping_details
      shipping_detail = Models::ShippingDetails.new
      address = create_address
      shipping_detail.shipping_address = address
      shipping_detail.shipping_method = Enums::ShippingMethod::NEXT_DAY
      shipping_detail.email = 'a@a.com'
      shipping_detail.fax = '1234'
      shipping_detail.first_name = 'John'
      shipping_detail.last_name = 'Smith'
      shipping_detail.phone = '0123456789'
      shipping_detail
    end

    def self.create_line_items
      line_item = Models::LineItem.new
      items = Array.new
      items.push(line_item)
      items
    end

    def self.create_refund_details
      refund_details = InternalModels::RefundDetails.new
      refund_details.currency_code = 'AUD'
      refund_details.invoice_description = 'Individual Invoice Description'
      refund_details.invoice_number = 'Inv 21540'
      refund_details.invoice_reference = '513456'
      refund_details.total_amount = 1000
    end

    def self.create_options
      options = Array.new
      options.push('Option 1')
      options
    end

    def self.create_settlement_transaction
      settlement_transaction = InternalModels::SettlementTransaction.new
      settlement_transaction.settlement_id = '53e78b14-ac2c-4b1b-a099-a12c6d5f30bc'
      settlement_transaction.eway_customer_id = 87654321
      settlement_transaction.currency = '36'
      settlement_transaction.currency_code = 'AUD'
      settlement_transaction.transaction_id = 11258912
      settlement_transaction.txn_reference = '0000000011258912'
      settlement_transaction.card_type = 'VI'
      settlement_transaction.amount = 100
      settlement_transaction.transaction_type = '1'
      settlement_transaction.transaction_date = '/Date(1422795600000)/'
      settlement_transaction.settlement_date = '/Date(1422795600000)/'
      settlement_transaction
    end

    def self.create_settlement_summary
      settlement_summary = InternalModels::SettlementSummary.new
      settlement_summary.settlement_id = '53e78b14-ac2c-4b1b-a099-a12c6d5f30bc'
      settlement_summary.currency = '36'
      settlement_summary.currency_code = 'AUD'
      settlement_summary.total_credit = 97100
      settlement_summary.total_debit = 320
      settlement_summary.total_balance = 96780
      settlement_summary
    end

    def self.create_balance
      balance = InternalModels::BalancePerCardType.new
      balance.card_type = 'VI'
      balance.number_of_transactions = 14
      balance.credit = 97100
      balance.debit = 320
      balance.balance = 94780
      balance
    end
  end
end
