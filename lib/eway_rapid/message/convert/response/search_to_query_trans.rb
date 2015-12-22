module EwayRapid
  module Message
    module Convert
      module Response
        class SearchToQueryTrans

          # @param [TransactionSearchResponse] response
          # @return [QueryTransactionResponse]
          def do_convert(response)
            query_transaction_response = QueryTransactionResponse.new

            if response.transactions && response.transactions.length > 0
              trans_convert = InternalTransToTrans.new
              query_transaction_response.transaction = trans_convert.do_convert(response.transactions[0])
            end

            query_transaction_response.errors = response.error.split(/\s*,\s*/) if response.error

            status_convert = InternalTransactionToStatus.new
            if response.transactions && response.transactions.length > 0
              query_transaction_response.transaction_status = status_convert.do_convert(response.transactions[0])
            end

            query_transaction_response
          end
        end
      end
    end
  end
end