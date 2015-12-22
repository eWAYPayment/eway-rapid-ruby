require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Response
        class DirectRefundToRefundResponseConverterTest < TestBase

          def setup
            @convert = DirectRefundToRefundResponse.new
            json = '{"AuthorisationCode":"480233","ResponseCode":null,"ResponseMessage":"A2000","TransactionID":11735642,"TransactionStatus":true,"Verification":null,"Customer":{"CardDetails":{"Number":"","Name":"","ExpiryMonth":"12","ExpiryYear":"25","StartMonth":"","StartYear":"","IssueNumber":""},"TokenCustomerID":null,"Reference":"","Title":"Mr.","FirstName":"John","LastName":"Smith","CompanyName":"eWAY","JobDescription":"Ruby Developer","Street1":"Level 5","Street2":"369 Queen Street","City":"Sydney","State":"NSW","PostalCode":"2000","Country":"au","Email":"","Phone":"0123456789","Mobile":"0123456789","Comments":"","Fax":"1234","Url":"http://www.ewaypayments.com"},"Refund":{"TransactionID":"11735641","TotalAmount":1000,"InvoiceNumber":"Inv 21540","InvoiceDescription":"Individual Invoice Description","InvoiceReference":"513456","CurrencyCode":"AUD"},"Errors":null}'
            @response = DirectRefundResponse.from_json(json)
          end

          def test_do_convert
            res = @convert.do_convert(@response)
            assert_equal(1000, res.refund.refund_details.total_amount, 0.001)
            assert_equal('John', res.refund.customer.first_name)
            assert_equal('12',res.refund.customer.card_details.expiry_month)
          end

          def teardown; end
        end
      end
    end
  end
end