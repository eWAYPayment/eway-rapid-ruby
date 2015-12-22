module EwayRapid
  #  Query transaction response
  class QueryTransactionResponse < ResponseOutput

    # The Request as returned by Rapid API. Where a token customer is created as
    # result of the transaction, then the Customer in this type will contain the
    # Customer Token ID
    attr_accessor :transaction

    # Contains transaction status information
    attr_accessor :transaction_status

    # AccessCode for this transaction
    attr_accessor :access_code
  end
end
