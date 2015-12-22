require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Response
        class DirectPaymentToCreateTransConverterTest < TestBase

          def setup
            @convert = DirectPaymentToCreateTrans.new
            json = '{"Errors":null,"AuthorisationCode":"843422","ResponseCode":"00","ResponseMessage":"A2000","TransactionID":11735584,"TransactionStatus":true,"TransactionType":"Purchase","BeagleScore":0,"Verification":{"CVN":0,"Address":0,"Email":0,"Mobile":0,"Phone":0},"Customer":{"CardDetails":{"Number":"444433XXXXXX1111","Name":"John Smith","ExpiryMonth":"12","ExpiryYear":"25","StartMonth":null,"StartYear":null,"IssueNumber":null},"TokenCustomerID":null,"Reference":"","Title":"Mr.","FirstName":"John","LastName":"Smith","CompanyName":"eWAY","JobDescription":"Ruby Developer","Street1":"Level 5","Street2":"369 Queen Street","City":"Sydney","State":"NSW","PostalCode":"2000","Country":"Au","Email":"","Phone":"0123456789","Mobile":"0123456789","Comments":"","Fax":"1234","Url":"http://www.ewaypayments.com"},"Payment":{"TotalAmount":1000,"InvoiceNumber":"Inv 21540","InvoiceDescription":"Individual Invoice Description","InvoiceReference":"513456","CurrencyCode":"AUD"}}'
            @response = DirectPaymentResponse.from_json(json)
          end

          def test_do_convert
            transRes = @convert.do_convert(@response)
            assert_equal(Enums::TransactionType::PURCHASE, transRes.transaction.transaction_type)
            assert_equal(1000, transRes.transaction.payment_details.total_amount, 0.001)
            assert_equal('John', transRes.transaction.customer.first_name)
            assert_equal('843422',transRes.transaction_status.processing_details.authorisation_code)
          end

          def teardown; end
        end
      end
    end
  end
end