module EwayRapid
  module Message
    module Convert
      module Request
        class RefundToDirectRefundReq

          # @param [Models::Refund] refund
          # @return [DirectRefundRequest]
          def do_convert(refund)
            request = DirectRefundRequest.new

            if refund
              shipping_convert = ShippingDetailsToAddress.new
              customer_convert = CustomerToInternalCustomer.new
              request.refund = refund.refund_details
              request.shipping_address = shipping_convert.do_convert(refund.shipping_details)
              request.customer = customer_convert.do_convert(refund.customer)
              request.partner_id = refund.partner_id
              request.device_id = refund.device_id
              request.line_items = refund.line_items

              # @type [Array]
              list_options = refund.options

              if list_options && list_options.length > 0
                list_convert = []
                list_options.each do |value|
                  op = InternalModels::Option.new
                  op.value = value
                  list_convert.push(op)
                end
                request.options = list_convert
              end
            end
            request
          end
        end
      end
    end
  end
end
