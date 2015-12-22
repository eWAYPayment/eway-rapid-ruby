require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Response
        class DirectPaymentToCreateCustConverterTest < TestBase

          def setup
            @convert = DirectPaymentToCreateCust.new
            json = '{"AuthorisationCode":null,"ResponseCode":"00","ResponseMessage":"A2000","TransactionID":null,"TransactionStatus":false,"TransactionType":"Purchase","BeagleScore":null,"Verification":{"CVN":0,"Address":0,"Email":0,"Mobile":0,"Phone":0},"Customer":{"CardDetails":{"Number":"444433XXXXXX1111","Name":"John Smith","ExpiryMonth":"12","ExpiryYear":"25","StartMonth":null,"StartYear":null,"IssueNumber":null},"TokenCustomerID":913079262890,"Reference":"","Title":"Mr.","FirstName":"John","LastName":"Smith","CompanyName":"eWAY","JobDescription":"Ruby Developer","Street1":"Level 5","Street2":"369 Queen Street","City":"Sydney","State":"NSW","PostalCode":"2000","Country":"Au","Email":"","Phone":"0123456789","Mobile":"0123456789","Comments":"","Fax":"1234","Url":"http://www.ewaypayments.com"},"Payment":{"TotalAmount":0,"InvoiceNumber":"","InvoiceDescription":"","InvoiceReference":"","CurrencyCode":"AUD"},"Errors":null}'
            @response = DirectPaymentResponse.from_json(json)
          end

          def test_do_convert
            customer_response = @convert.do_convert(@response)
            assert_equal('John', customer_response.customer.first_name)
            assert_equal('Level 5', customer_response.customer.address.street1)
            assert_equal('12',customer_response.customer.card_details.expiry_month)
          end

          def teardown; end
        end
      end
    end
  end
end