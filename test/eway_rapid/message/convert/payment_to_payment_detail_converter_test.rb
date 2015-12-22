require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class PaymentToPaymentDetailConverterTest < TestBase

        def setup
          @convert = PaymentToPaymentDetails.new
        end

        def test_do_convert
          payment = ObjectCreator.create_payment
          payment_details = @convert.do_convert(payment)
          assert_equal(1000, payment_details.total_amount,0.001)
        end

        def test_nil_payment
          payment_details = @convert.do_convert(nil)
          assert_equal(0, payment_details.total_amount)
        end

        def teardown

        end
      end
    end
  end
end
