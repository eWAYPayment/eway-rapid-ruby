module EwayRapid
  class CapturePaymentRequest
    attr_accessor :transaction_id
    attr_accessor :payment

    def to_json(options={})
      {Constants::REQUEST_TRANSACTION_ID  => transaction_id,
       Constants::PAYMENT                 => InternalModels::Payment.to_hash(payment)}.to_json
    end
  end
end
