module EwayRapid
  #  Settlement search response
  class SettlementSearchResponse < ResponseOutput

    # Array of daily settlement summaries
    attr_accessor :settlement_summaries

    # Array of settlement transactions
    attr_accessor :settlement_transactions
  end
end
