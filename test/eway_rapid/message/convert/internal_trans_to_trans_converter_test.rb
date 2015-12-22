require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class InternalTransToTransConverterTest < TestBase

        def setup
          @convert = InternalTransToTrans.new
        end

        def test_do_convert
          internal_tran = ObjectCreator.create_internal_transaction
          internal_tran.customer = ObjectCreator.create_internal_customer
          tran = @convert.do_convert(internal_tran)
          assert_equal('John', tran.customer.first_name)
          assert_equal(1000, tran.payment_details.total_amount, 0.001)
          assert_equal('Sydney', tran.shipping_details.shipping_address.city)
        end

        def teardown

        end
      end
    end
  end
end