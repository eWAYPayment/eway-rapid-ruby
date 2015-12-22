module EwayRapid
  module Message
    module Convert
      class TransactionToArrLineItem

        # @param [Models::Transaction] transaction
        # @return [Array]
        def do_convert(transaction)
          transaction.line_items || []
        end
      end
    end
  end
end
