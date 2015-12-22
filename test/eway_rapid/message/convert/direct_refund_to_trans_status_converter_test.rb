require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class DirectRefundToTransStatusConverterTest < TestBase

        def setup
          @convert = DirectRefundToTransStatus.new
        end

        def test_do_convert
          response = DirectRefundResponse.new
          response.transaction_id = '123456'
          response.transaction_status = true
          status = @convert.do_convert(response)
          assert_equal(123456, status.transaction_id)
          assert(status.status)
        end

        def test_invalid_transaction_id
          assert_raise ArgumentError do
            response = DirectRefundResponse.new
            response.transaction_id = 'abcd'
            @convert.do_convert(response)
          end
        end

        def teardown

        end
      end
    end
  end
end