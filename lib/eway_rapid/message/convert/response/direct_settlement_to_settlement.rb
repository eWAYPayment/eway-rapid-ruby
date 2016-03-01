module EwayRapid
  module Message
    module Convert
      module Response
        class DirectSettlementToSettlement

          # @param [DirectSettlementSearchResponse] response
          # @return [SettlementSearchResponse]
          def do_convert(response)
            settlement_search_response = SettlementSearchResponse.new

            if response.settlement_summaries && response.settlement_summaries.length > 0
              summary_convert = InternalSummaryToSummary.new
              settlement_search_response.settlement_summaries = []
              response.settlement_summaries.each {|summary|
                obj = summary_convert.do_convert(summary)
                settlement_search_response.settlement_summaries.push(obj)
              }
            end

            if response.settlement_transactions && response.settlement_summaries.length > 0
              settlement_convert = InternalSettlementToSettlement.new
              settlement_search_response.settlement_transactions = []
              response.settlement_transactions.each {|transaction|
                obj = settlement_convert.do_convert(transaction)
                settlement_search_response.settlement_transactions.push(obj)
              }
            end

            settlement_search_response.errors = response.error.split(/\s*,\s*/) if response.error

            settlement_search_response
          end
        end
      end
    end
  end
end