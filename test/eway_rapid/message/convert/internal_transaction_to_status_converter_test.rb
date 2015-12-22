require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class InternalTransactionToStatusConverterTest < TestBase

        def setup
          @convert = InternalTransactionToStatus.new
        end

        def test_do_convert
          transaction = ObjectCreator.create_internal_transaction
          status = @convert.do_convert(transaction)
          assert_equal(1000, status.total, 0.001)
        end

        def test_invalid_transaction_id
          assert_raise ArgumentError do
            transaction = ObjectCreator.create_internal_transaction
            transaction.transaction_id = 'abc'
            @convert.do_convert(transaction)
          end
        end

        def teardown

        end
      end
    end
  end
end