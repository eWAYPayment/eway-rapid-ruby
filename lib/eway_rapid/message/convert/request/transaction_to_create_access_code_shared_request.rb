module EwayRapid
  module Message
    module Convert
      module Request
        class TransactionToCreateAccessCodeSharedRequest

          # @param [Models::Transaction] input
          # @return [CreateAccessCodeSharedRequest]
          def do_convert(input)
            request = CreateAccessCodeSharedRequest.new

            if input
              request.cancel_url = input.cancel_url
              request.transaction_type = input.transaction_type
              request.device_id = input.device_id
              request.partner_id = input.partner_id
              request.redirect_url = input.redirect_url
              request.custom_view = input.custom_view
              request.header_text = input.header_text
              request.customer_ip = input.customer.customer_device_ip if input.customer
              request.logo_url = input.logo_url
              request.language = input.language
              request.verify_customer_email = input.verify_customer_email
              request.verify_customer_phone = input.verify_customer_phone
              request.customer_read_only = input.customer_read_only

              internal_cust_convert = CustomerToInternalCustomer.new
              request.customer = internal_cust_convert.do_convert(input.customer)

              ship_address_convert = TransactionShippingAddress.new
              request.shipping_address = ship_address_convert.do_convert(input)

              payment_convert = TransactionToPayment.new
              request.payment = payment_convert.do_convert(input)

              line_item_convert = TransactionToArrLineItem.new
              request.items = line_item_convert.do_convert(input)

              option_converter = TransactionToArrOption.new
              request.options = option_converter.do_convert(input)

              request.method = if input.capture
                                 if input.customer && (input.customer.token_customer_id || input.save_customer)
                                   Enums::RequestMethod::TOKEN_PAYMENT
                                 else
                                   Enums::RequestMethod::PROCESS_PAYMENT
                                 end
                               else
                                 Enums::RequestMethod::AUTHORISE
                               end
            end
            request
          end
        end
      end
    end
  end
end
