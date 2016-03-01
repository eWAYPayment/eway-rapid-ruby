require_relative '../lib/eway_rapid'
module EwayRapid
  class InputModelFactory

    # @return [Models::Transaction]
    def self.create_transaction
      transaction = Models::Transaction.new
      transaction.partner_id = '9889897'
      transaction.cancel_url = ''
      transaction.capture = true
      transaction.checkout_url = true
      transaction.redirect_url = 'http://www.eway.com.au'
      transaction.device_id = '546545'
      transaction.transaction_type = Enums::TransactionType::PURCHASE
      list_option = Array.new
      list_option.push('Option1')
      transaction.options = list_option
      list_item = Array.new
      item = Models::LineItem.new
      item.sku = '12345678901234567890'
      item.description = 'Item Description 1'
      item.quantity = 1
      item.unit_cost = 400
      item.tax = 100
      item.total = 500
      list_item.push(item)
      transaction.line_items = list_item
      transaction
    end

    def self.create_customer
      customer = Models::Customer.new
      customer.title = 'Mr.'
      customer.first_name = 'John'
      customer.last_name = 'Smith'
      customer.company_name = 'eWay'
      customer.job_description = 'Ruby Developer'
      customer.phone = '0123456789'
      customer.mobile = '0123456789'
      customer.url = 'http://www.ewaypayments.com'
      customer.redirect_url = 'http://www.eway.com.au'
      customer.email = 'xxx@gmail.com'
      customer
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

    def self.create_address_by_object(city, country, postal_code, state)
      address = Models::Address.new
      address.city = city
      address.country = country
      address.postal_code = postal_code
      address.state = state
      address
    end

    def self.create_payment_details
      payment_details = Models::PaymentDetails.new
      payment_details.currency_code = 'AUD'
      payment_details.invoice_description = 'Individual Invoice Description'
      payment_details.invoice_number = 'Inv 21540'
      payment_details.invoice_reference = '513456'
      payment_details.total_amount = 1000
      payment_details
    end

    def self.create_payment_details_with(invoice_number, invoice_reference)
      payment_details = Models::PaymentDetails.new
      payment_details.currency_code = 'AUD'
      payment_details.invoice_description = 'Individual Invoice Description'
      payment_details.invoice_number = invoice_number
      payment_details.invoice_reference = invoice_reference
      payment_details.total_amount = 1000
      payment_details
    end

    def self.create_card_detail(expiry_month, expiry_year)
      card_details = Models::CardDetails.new
      card_details.name = 'John Smith'
      card_details.number = '4444333322221111'
      card_details.expiry_month = expiry_month
      card_details.expiry_year = expiry_year
      card_details.cvn = '123'
      card_details
    end

    def self.create_shipping_detail
      shipping_detail = Models::ShippingDetails.new
      shipping_detail.shipping_method = Enums::ShippingMethod::LOW_COST
      shipping_detail.email = 'someone@yahoo.com'
      shipping_detail.fax = '12345689'
      shipping_detail.first_name = 'Dave'
      shipping_detail.last_name = 'David'
      shipping_detail.phone = '0123456789'
      shipping_detail
    end

    def self.create_settlement_search
      settlement_search = Models::SettlementSearch.new
      settlement_search.report_mode = 'Both'
      settlement_search.settlement_date = '2016-02-02'
      settlement_search.card_type = Enums::CardType::VISA
      settlement_search
    end

    def self.random_string(number)
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      (0...number).map { o[rand(o.length)] }.join
    end
  end
end
