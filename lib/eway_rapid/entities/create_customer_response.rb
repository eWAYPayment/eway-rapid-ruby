module EwayRapid
  class CreateCustomerResponse < ResponseOutput
    attr_accessor :customer
    attr_accessor :shared_payment_url
    attr_accessor :form_action_url
    attr_accessor :access_code
  end
end
