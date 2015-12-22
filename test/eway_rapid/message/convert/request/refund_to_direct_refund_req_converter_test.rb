require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Request
        class RefundToDirectRefundReqConverterTest < TestBase
          def setup
            @convert = RefundToDirectRefundReq.new
            @refund = Models::Refund.new
            refund_details = ObjectCreator.create_refund_details
            customer = ObjectCreator.create_external_customer
            address = ObjectCreator.create_address
            card_details = ObjectCreator.create_card_details
            customer.card_details = card_details
            customer.address = address
            shipping_details = Models::ShippingDetails.new
            shipping_details.shipping_address = address
            line_items = ObjectCreator.create_line_items
            @refund.line_items = line_items
            options=ObjectCreator.create_options
            @refund.options = options
            @refund.customer = customer
            @refund.shipping_details = shipping_details
            @refund.refund_details = refund_details
            @refund.device_id = 'DZPC'
            @refund.partner_id = 'ID'
          end

          def test_do_convert
            request = @convert.do_convert(@refund)
            assert_equal('John', request.customer.first_name)
            assert_equal('Sydney', request.shipping_address.city)
            assert_equal(1, request.line_items.length)
            assert_equal(1, request.options.length)
          end

          def teardown

          end
        end
      end
    end
  end
end