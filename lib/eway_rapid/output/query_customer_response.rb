module EwayRapid
  # Query customer response data
  class QueryCustomerResponse < ResponseOutput
    attr_accessor :token_customer_id
    attr_accessor :state
    attr_accessor :postal_code
    attr_accessor :email
    attr_accessor :reference
    attr_accessor :title
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :company_name
    attr_accessor :job_description
    attr_accessor :street1
    attr_accessor :street2
    attr_accessor :city
    attr_accessor :phone
    attr_accessor :mobile
    attr_accessor :url
    attr_accessor :card_detail
    attr_accessor :country
    attr_accessor :comments
    attr_accessor :fax
  end
end
