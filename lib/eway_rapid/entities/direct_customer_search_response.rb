module EwayRapid
  class DirectCustomerSearchResponse
    attr_accessor :customers
    attr_accessor :errors

    def to_json(options={})
      {Constants::CUSTOMERS => customers,
       Constants::ERRORS => errors}.to_json
    end

    def self.from_json(json)
      hash = JSON.parse(json)
      from_hash(hash)
    end

    def self.from_hash(hash)
      response = DirectCustomerSearchResponse.new
      response.customers = InternalModels::Customer.from_array(hash[Constants::CUSTOMERS])
      response.errors = hash[Constants::ERRORS_CAPITALIZED]
      response
    end
  end
end
