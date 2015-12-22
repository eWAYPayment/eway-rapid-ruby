require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class TransactionToShippingAddressConverterTest < TestBase

        def setup
          @convert = TransactionShippingAddress.new
        end

        def test_do_convert
          transaction = ObjectCreator.create_transaction
          transaction.shipping_details = ObjectCreator.create_shipping_details
          address = @convert.do_convert(transaction)
          assert_equal('Sydney', address.city)
        end

        def test_nil_shipping_detail
          t = ObjectCreator.create_transaction
          address = @convert.do_convert(t)
          assert_nil(address.city)
        end

        def test_nil_address
          transaction = ObjectCreator.create_transaction
          transaction.shipping_details = ObjectCreator.create_shipping_details
          transaction.shipping_details.shipping_address = nil
          address = @convert.do_convert(transaction)
          assert_nil(address.city)
        end

        def teardown; end
      end
    end
  end
end