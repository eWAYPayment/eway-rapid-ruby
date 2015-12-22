module EwayRapid
  module Message
    module Convert
      class ShippingDetailsToAddress

        # @param [Models::ShippingDetails] detail
        # @return [InternalModels::ShippingAddress]
        def do_convert(detail)
          address = InternalModels::ShippingAddress.new

          if detail
            # @type [InternalModels::ShippingAddress]
            add = detail.shipping_address

            if add
              address.city = add.city
              address.country = add.country
              address.state = add.state
              address.street1 = add.street1
              address.street2 = add.street2
              address.postal_code = add.postal_code
            end

            address.first_name = detail.first_name
            address.last_name = detail.last_name
            address.phone = detail.phone
            address.fax = detail.fax
            address.shipping_method = detail.shipping_method || ''
          end
          address
        end
      end
    end
  end
end
