require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class InternalTransactionToAddressConverterTest < TestBase

        def setup
          @convert = InternalTransactionToAddress.new
        end

        def test_do_convert
          transaction = ObjectCreator.create_internal_transaction
          address = @convert.do_convert(transaction)
          assert_equal('Sydney', address.city)
        end

        def teardown

        end
      end
    end
  end
end