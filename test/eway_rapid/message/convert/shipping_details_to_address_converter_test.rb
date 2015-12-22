require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
class ShippingDetailsToAddressConverterTest < TestBase

  def setup
    @convert = ShippingDetailsToAddress.new
  end

  def test_do_convert
    detail = ObjectCreator.create_shipping_details
    address = @convert.do_convert(detail)
    assert_equal('John', address.first_name)
    assert_equal('Sydney', address.city)
    assert_equal(Enums::ShippingMethod::NEXT_DAY, address.shipping_method)
  end

  def test_nil_shipping_detail
    address = @convert.do_convert(nil)
    assert_nil(address.first_name)
  end

  def test_nil_address
    detail = ObjectCreator.create_shipping_details
    detail.shipping_address = nil
    detail.shipping_method = nil
    address = @convert.do_convert(detail)
    assert_nil(address.city)
  end

  def teardown

  end
end
    end
  end
end
