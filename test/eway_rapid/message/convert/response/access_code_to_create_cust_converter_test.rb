require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Response
        class AccessCodeToCreateCustConverterTest < TestBase

          def setup
            @convert = AccessCodeToCreateCust.new
            json = '{"AccessCode":"C3AB9ps780Y_gslZ4qpPNvOUwynNt-HOLzfvNDAoxxCfljjZiFPJIrYs4k0TpSAaYWw2AGxNH3hZfIlqKdCX_qGgzVTa8jBFSFSTv3wwk9CiNIWVAOm64gHAS6frxFkmqHmOc","Customer":{"CardNumber":"","CardStartMonth":"","CardStartYear":"","CardIssueNumber":"","CardName":"","CardExpiryMonth":"","CardExpiryYear":"","IsActive":false,"TokenCustomerID":null,"Reference":"","Title":"Mr.","FirstName":"John","LastName":"Smith","CompanyName":"eWAY","JobDescription":"Ruby Developer","Street1":"Level 5","Street2":"369 Queen Street","City":"Sydney","State":"NSW","PostalCode":"2000","Country":"au","Email":"","Phone":"0123456789","Mobile":"0123456789","Comments":"","Fax":"1234","Url":"http://www.ewaypayments.com"},"Payment":{"TotalAmount":0,"InvoiceNumber":null,"InvoiceDescription":null,"InvoiceReference":null,"CurrencyCode":"AUD"},"FormActionURL":"https://secure-au.sandbox.ewaypayments.com/Process","CompleteCheckoutURL":null,"Errors":null}'
            @response = CreateAccessCodeResponse.from_json(json)
          end

          def test_do_convert
            customer_response = @convert.do_convert(@response)
            assert_equal('John', customer_response.customer.first_name)
            assert_equal('Level 5', customer_response.customer.address.street1)
          end

          def teardown; end
        end
      end
    end
  end
end