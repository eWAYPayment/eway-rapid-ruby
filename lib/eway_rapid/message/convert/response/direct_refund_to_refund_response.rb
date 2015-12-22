module EwayRapid
  module Message
    module Convert
      module Response
        class DirectRefundToRefundResponse

          # @param [DirectRefundResponse] response
          # @return [RefundResponse]
          def do_convert(response)
            refund = Models::Refund.new
            refund.refund_details = response.refund

            cust_convert = InternalCustomerToCustomer.new
            refund.customer = cust_convert.do_convert(response.customer)

            refund_response = RefundResponse.new
            refund_response.errors = response.errors.split(/\s*,\s*/) if response.errors
            refund_response.refund = refund

            trans_status_convert = DirectRefundToTransStatus.new
            refund_response.transaction_status = trans_status_convert.do_convert(response)
            refund_response
          end
        end
      end
    end
  end
end
