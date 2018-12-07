module EwayRapid
  # Create transaction response
  class CreateTransactionResponse < ResponseOutput

    # The transaction as returned by Rapid API.
    attr_accessor :transaction

    # Contains transaction status information
    attr_accessor :transaction_status

    # URL to the Responsive Shared Page that the cardholder's browser should
    # be redirected to (Only for Responsive Shared)
    attr_accessor :shared_payment_url

    # URL that the merchant's credit card form should post to to complete
    # payment (Only for Transparent Redirect)
    attr_accessor :form_action_url

    # An AccessCode for this transaction (Used with Transparent Redirect
    # and Responsive Shared)
    attr_accessor :access_code

    # (v40+ only) A token used to configure AMEX Express Checkout
    attr_accessor :amex_ec_data

  end
end
