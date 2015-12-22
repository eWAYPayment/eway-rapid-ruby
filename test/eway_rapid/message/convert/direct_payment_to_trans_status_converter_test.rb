require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class DirectPaymentToTransStatusConverterTest < TestBase
        def setup
          @convert = DirectPaymentToTransStatus.new
        end

        def test_do_convert
          response = DirectPaymentResponse.new
          response.transaction_id = '123456'
          response.beagle_score = 0.0
          response.fraud_action = Enums::FraudAction::ALLOW
          response.transaction_captured = 'true'
          response.transaction_status = true
          payment = ObjectCreator.create_payment
          response.payment = payment
          verification = ObjectCreator.create_verification
          response.verification = verification
          status = @convert.do_convert(response)
          assert_equal(response.beagle_score, 0.0, 0.001)
          assert_equal(Enums::FraudAction::ALLOW, status.fraud_action)
          assert(status.captured)
        end

        def test_invalid_transaction_id
          assert_raise ArgumentError do
            response = DirectPaymentResponse.new
            response.transaction_id = 'abcd'
            payment = ObjectCreator.create_payment
            response.payment = payment
            @convert.do_convert(response)
          end
        end

        def test_invalid_verification
          response = DirectPaymentResponse.new
          response.transaction_id = '1234'
          payment = ObjectCreator.create_payment
          response.payment = payment
          verification = ObjectCreator.create_verification
          verification.address = 'a'
          response.verification = verification
          @convert.do_convert(response)
        end

        def teardown

        end
      end
    end
  end
end