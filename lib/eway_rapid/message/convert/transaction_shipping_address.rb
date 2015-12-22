module EwayRapid
  module Message
    module Convert
      class TransactionShippingAddress

        # @param [Models::Transaction] transaction
        # @return [InternalModels::ShippingAddress]
        def do_convert(transaction)
          shipping_address = InternalModels::ShippingAddress.new

          # @type [Models::ShippingDetails]
          detail = transaction.shipping_details
          if detail
            shipping_address.first_name = detail.first_name
            shipping_address.last_name = detail.last_name
            shipping_address.shipping_method = detail.shipping_method
            shipping_address.email = detail.email
            shipping_address.phone = detail.phone
            shipping_address.fax = detail.fax

            # @type [Models::Address]
            address = detail.shipping_address
            if address
              shipping_address.city = address.city
              shipping_address.country = address.country
              shipping_address.postal_code = address.postal_code
              shipping_address.state = address.state
              shipping_address.street1 = address.street1
              shipping_address.street2 = address.street2
            end
          end
          shipping_address
        end
      end
    end
  end
end
