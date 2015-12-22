module EwayRapid
  class TransactionSearchResponse
    attr_accessor :transactions
    attr_accessor :error

    def to_json(options={})
      {Constants::TRANSACTIONS => transactions,
       Constants::ERRORS_CAPITALIZED => error}.to_json
    end

    def self.from_json(json)
      hash = JSON.parse(json)
      from_hash(hash)
    end

    def self.from_hash(hash)
      transaction_search_response = TransactionSearchResponse.new
      transaction_search_response.transactions = InternalModels::Transaction.from_array(hash[Constants::TRANSACTIONS])
      transaction_search_response.error = hash[Constants::ERRORS_CAPITALIZED]
      transaction_search_response
    end
  end
end
