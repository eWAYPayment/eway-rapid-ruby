module EwayRapid
  module Message
    module Convert
      module Request
        class TransactionToCreateAccessCodeRequest

          # @param [Models::Transaction] transaction
          # @return [CreateAccessCodeRequest]
          def do_convert(transaction)
            request = CreateAccessCodeRequest.new

            if transaction
              request.transaction_type = transaction.transaction_type
              request.device_id = transaction.device_id
              request.partner_id = transaction.partner_id
              request.redirect_url = transaction.redirect_url
              # request.payment.total_amount = transaction.payment_details.total_amount if transaction.payment_details

              if transaction.customer
                internal_cust_convert = CustomerToInternalCustomer.new(false)
                request.customer = internal_cust_convert.do_convert(transaction.customer)
                request.customer_ip = transaction.customer.customer_device_ip
              end

              ship_address_convert = TransactionShippingAddress.new
              request.shipping_address = ship_address_convert.do_convert(transaction)

              payment_convert = TransactionToPayment.new
              request.payment = payment_convert.do_convert(transaction)

              if transaction.checkout_url
                request.checkout_payment = transaction.checkout_payment
                request.checkout_url = transaction.checkout_url
              end

              line_item_convert = TransactionToArrLineItem.new
              request.items = line_item_convert.do_convert(transaction)

              option_convert = TransactionToArrOption.new
              request.options = option_convert.do_convert(transaction)

              if transaction.shipping_details && transaction.shipping_details.shipping_method
                request.shipping_method = transaction.shipping_details.shipping_method
              end

              request.method = if transaction.capture
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
