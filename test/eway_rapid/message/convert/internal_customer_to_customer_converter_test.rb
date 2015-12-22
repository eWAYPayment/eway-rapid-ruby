require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class InternalCustomerToCustomerConverterTest < TestBase

        def setup
          @convert = InternalCustomerToCustomer.new
        end

        def test_do_convert
          internal_customer = ObjectCreator.create_internal_customer
          customer = @convert.do_convert(internal_customer)
          assert_equal('John', customer.first_name)
          assert_equal('12', customer.card_details.expiry_month)
        end

        def teardown

        end
      end
    end
  end
end