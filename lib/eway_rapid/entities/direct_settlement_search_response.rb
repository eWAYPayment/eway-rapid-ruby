module EwayRapid
  class DirectSettlementSearchResponse
    attr_accessor :settlement_summaries
    attr_accessor :settlement_transactions
    attr_accessor :error

    def to_json(summaries={}, transactions={})
      {Constants::SETTLEMENT_SUMMARIES => summaries,
       Constants::SETTLEMENT_TRANSACTIONS => transactions,
       Constants::ERRORS_CAPITALIZED => error}.to_json
    end

    def self.from_json(json)
      hash = JSON.parse(json)
      from_hash(hash)
    end

    def self.from_hash(hash)
      settlement_search_response = DirectSettlementSearchResponse.new
      settlement_search_response.settlement_summaries = InternalModels::SettlementSummary.from_array(hash[Constants::SETTLEMENT_SUMMARIES])
      settlement_search_response.settlement_transactions = InternalModels::SettlementTransaction.from_array(hash[Constants::SETTLEMENT_TRANSACTIONS])
      settlement_search_response.error = hash[Constants::ERRORS_CAPITALIZED]
      settlement_search_response
    end
  end
end
