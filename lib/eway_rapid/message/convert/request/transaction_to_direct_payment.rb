module EwayRapid
  module Message
    module Convert
      module Request
        class TransactionToDirectPayment

          # @param [Models::Transaction] input
          # @return [DirectPaymentRequest]
          def do_convert(input)
            request = DirectPaymentRequest.new
            inter_cust_convert = CustomerToInternalCustomer.new

            if input.customer
              request.customer_ip = input.customer.customer_device_ip
              request.customer = inter_cust_convert.do_convert(input.customer)
            end

            payment_convert = TransactionToPayment.new
            request.payment = payment_convert.do_convert(input)

            ship_converter = TransactionShippingAddress.new
            request.shipping_address = ship_converter.do_convert(input)

            line_item_convert = TransactionToArrLineItem.new
            request.items = line_item_convert.do_convert(input)

            option_converter = TransactionToArrOption.new
            request.options = option_converter.do_convert(input)

            request.device_id = input.device_id
            request.partner_id = input.partner_id
            request.transaction_type = input.transaction_type || ''
            request.secured_card_data = input.secured_card_data
            request.method = if input.capture
                               Enums::RequestMethod::PROCESS_PAYMENT
                             else
                               Enums::RequestMethod::AUTHORISE
                             end
            request.redirect_url = input.redirect_url
            request
          end
        end
      end
    end
  end
end
