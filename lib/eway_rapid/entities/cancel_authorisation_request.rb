module EwayRapid
  class CancelAuthorisationRequest
    attr_accessor :transaction_id

    def to_json(options={})
      { Constants::REQUEST_TRANSACTION_ID => transaction_id }.to_json
    end
  end
end
