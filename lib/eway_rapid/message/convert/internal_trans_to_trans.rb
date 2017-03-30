module EwayRapid
  module Message
    module Convert
      class InternalTransToTrans

        # @param [InternalModels::Transaction] i_transaction
        # @return [Models::Transaction]
        def do_convert(i_transaction)
          transaction = Models::Transaction.new
          transaction.customer = get_eway_customer(i_transaction)
          transaction.payment_details = get_payment_details(i_transaction)
          transaction.shipping_details = get_shipping_details(i_transaction)
          transaction.token_customer_id = i_transaction.token_customer_id
          transaction.options = i_transaction.options
          transaction
        end

        # @param [InternalModels::Transaction] i_transaction
        # @return [Models::Customer]
        def get_eway_customer(i_transaction)
          # @type [InternalModels::Customer]
          i_customer = i_transaction.customer
          customer_convert = InternalCustomerToCustomer.new

          # @type [Models::Customer]
          customer = customer_convert.do_convert(i_customer)
          address_convert = InternalTransactionToAddress.new
          customer.address = address_convert.do_convert(i_transaction)
          customer
        end

        # @param [InternalModels::Transaction] i_transaction
        # @return [Models::PaymentDetails]
        def get_payment_details(i_transaction)
          payment_details = Models::PaymentDetails.new
          payment_details.total_amount = i_transaction.total_amount
          payment_details.invoice_reference = i_transaction.invoice_reference
          payment_details.invoice_number = i_transaction.invoice_number
          payment_details
        end

        # @param [InternalModels::Transaction] i_transaction
        # @return [Models::ShippingDetails]
        def get_shipping_details(i_transaction)
          shipping_details = Models::ShippingDetails.new

          if i_transaction.shipping_address
            address_convert = InternalTransactionToAddress.new
            shipping_details.shipping_address = address_convert.do_convert(i_transaction)
            shipping_details.shipping_method = i_transaction.shipping_address.shipping_method || ''
            shipping_details.first_name = i_transaction.shipping_address.first_name
            shipping_details.last_name = i_transaction.shipping_address.last_name
            shipping_details.email = i_transaction.shipping_address.email
            shipping_details.fax = i_transaction.shipping_address.fax
            shipping_details.phone = i_transaction.shipping_address.phone
          end

          shipping_details
        end
      end
    end
  end
end
