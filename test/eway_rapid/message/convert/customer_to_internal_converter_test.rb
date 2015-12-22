require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class CustomerToInternalConverterTest < TestBase
        def setup
          @convert = CustomerToInternalCustomer.new
        end

        def test_convert_customer_card_detail
          cust = InputModelFactory.create_customer
          cust.card_details = InputModelFactory.create_card_detail('12', '25')
          inter_cust = @convert.do_convert(cust)
          detail = inter_cust.card_details
          assert_not_nil(detail)
          assert_not_nil(detail.expiry_month)
          assert_not_nil(detail.expiry_year)
          assert_equal('12', detail.expiry_month)
          assert_equal('25', detail.expiry_year)
        end

        def test_convert_customer_address
          cust = InputModelFactory.create_customer
          city = 'Sydney'
          postal_code = '084'
          state = 'NSW'
          country = 'Autralia'
          add = InputModelFactory.create_address_by_object(city, country, postal_code, state)
          cust.address = add
          inter_cust = @convert.do_convert(cust)
          assert_not_nil(inter_cust.state)
          assert_equal(state, inter_cust.state)
          assert_not_nil(inter_cust.city)
          assert_equal(city, inter_cust.city)
          assert_not_nil(inter_cust.country)
          assert_equal(country, inter_cust.country)
          assert_not_nil(inter_cust.postal_code)
          assert_equal(postal_code, inter_cust.postal_code)
        end

        def test_convert_customer_without_address
          cust = InputModelFactory.create_customer
          interCust = @convert.do_convert(cust)
          assert_nil(interCust.state)
          assert_nil(interCust.city)
          assert_nil(interCust.country)
          assert_nil(interCust.postal_code)
        end
      end
    end
  end
end