require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Response
        class AccessCodeToCreateTransConverterTest < TestBase

          def setup
            @convert = AccessCodeToCreateTrans.new
            json = '{"AccessCode":"60CF3L9mWK-zQ9wxakOtyfjcBpNSRIngC2X2gudGR07jB7w_a8RgW6vp3YfmUCXK9cuywC8whzukY6TldEWlq0digXA_OOlwOr5rrUiHtL6EzruLWCQS-1byCuv_lgWz8hBMp","Customer":{"CardNumber":"","CardStartMonth":"","CardStartYear":"","CardIssueNumber":"","CardName":"","CardExpiryMonth":"","CardExpiryYear":"","IsActive":false,"TokenCustomerID":null,"Reference":"","Title":"Mr.","FirstName":"John","LastName":"Smith","CompanyName":"eWAY","JobDescription":"Ruby Developer","Street1":"Level 5","Street2":"369 Queen Street","City":"Sydney","State":"NSW","PostalCode":"2000","Country":"au","Email":"","Phone":"0123456789","Mobile":"0123456789","Comments":"","Fax":"1234","Url":"http://www.ewaypayments.com"},"Payment":{"TotalAmount":1000,"InvoiceNumber":"Inv 21540","InvoiceDescription":"Individual Invoice Description","InvoiceReference":"513456","CurrencyCode":"AUD"},"FormActionURL":"https://secure-au.sandbox.ewaypayments.com/Process","CompleteCheckoutURL":null,"Errors":null}'
            @response = CreateAccessCodeResponse.from_json(json)
          end

          def test_do_convert
            transRes = @convert.do_convert(@response)
            assert_equal(1000, transRes.transaction.payment_details.total_amount, 0.001)
            assert_equal('John', transRes.transaction.customer.first_name)
          end

          def teardown; end
        end
      end
    end
  end
end