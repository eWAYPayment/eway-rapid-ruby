module EwayRapid
  module Message
    module Convert
      class InternalTransactionToAddress

        # @param [InternalModels::Transaction] i_transaction
        # @return [Models::Address]
        def do_convert(i_transaction)
          address = Models::Address.new

          # @type [InternalModels::ShippingAddress]
          shipping_address = i_transaction.shipping_address

          if shipping_address
            address.state = shipping_address.state
            address.street1 = shipping_address.street1
            address.postal_code = shipping_address.postal_code
            address.city = shipping_address.city
            address.country = shipping_address.country
            address.street2 = shipping_address.street2
          end
          address
        end
      end
    end
  end
end
