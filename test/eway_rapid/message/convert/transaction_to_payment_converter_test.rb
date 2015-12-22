require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class TransactionToPaymentConverterTest < TestBase

        def setup
          @convert = TransactionToPayment.new
        end

        def test_do_convert
          transaction = ObjectCreator.create_transaction
          transaction.payment_details = ObjectCreator.create_payment_details
          payment = @convert.do_convert(transaction)
          assert_equal(1000, payment.total_amount, 0.001)
        end

        def test_nil_payment
          t = ObjectCreator.create_transaction
          payment = @convert.do_convert(t)
          assert_equal(0, payment.total_amount)
        end

        def teardown; end
      end
    end
  end
end