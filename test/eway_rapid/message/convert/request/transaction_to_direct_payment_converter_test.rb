require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Request
        class TransactionToDirectPaymentConverterTest < TestBase
          def setup
            @convert = TransactionToDirectPayment.new
            customer = ObjectCreator.create_external_customer
            address = ObjectCreator.create_address
            card_details = ObjectCreator.create_card_details
            payment_details = ObjectCreator.create_payment_details
            @input = Models::Transaction.new
            customer.card_details = card_details
            customer.address = address
            @input.customer = customer
            @input.payment_details = payment_details
            @input.transaction_type = Enums::TransactionType::PURCHASE
            @input.secured_card_data = ObjectCreator.create_secured_card_data
            @input.capture = true
          end

          def test_do_convert
            request = @convert.do_convert(@input)
            assert_equal(1000, request.payment.total_amount,0.001)
            assert_equal('John', request.customer.first_name)
            assert_equal('Level 5', request.customer.street1)
            assert_equal('12',request.customer.card_details.expiry_month)
            assert_equal(@input.secured_card_data,request.secured_card_data)
            assert_equal(Enums::TransactionType::PURCHASE,request.transaction_type)
          end
        end
      end
    end
  end
end
