module EwayRapid
  module Message
    module Convert
      class TransactionToArrOption

        # @param [Models::Transaction] transaction
        # @return [Array]
        def do_convert(transaction)
          if transaction.options
            list_option = Array.new

            transaction.options.each do |opt|
              option = InternalModels::Option.new
              option.value = opt
              list_option.push(option)
            end
            list_option
          else
            Array.new(3)
          end
        end
      end
    end
  end
end
