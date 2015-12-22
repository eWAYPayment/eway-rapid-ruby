module EwayRapid
  # Refund response
  class RefundResponse < ResponseOutput
    attr_accessor :refund

    # Contains transaction status information
    attr_accessor :transaction_status
  end
end
