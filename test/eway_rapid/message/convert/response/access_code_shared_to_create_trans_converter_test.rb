require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Response
        class AccessCodeSharedToCreateTransConverterTest < TestBase

          def setup
            @convert = AccessCodeSharedToCreateTrans.new
            json = '{"SharedPaymentUrl":"https://secure-au.sandbox.ewaypayments.com/sharedpage/sharedpayment?AccessCode=F9802QqDnIqsLNfb1_rjKo2LA8P-RAalL-7TkBkYaDLRLuh-KDFqKVuvD0hhCmaWvqNhTnf07s2Kqhkru_nyySX-ZAjqRz6675u4tlZlFi1huKGXA2aFcS_l4BXlvmralGqtj","AccessCode":"F9802QqDnIqsLNfb1_rjKo2LA8P-RAalL-7TkBkYaDLRLuh-KDFqKVuvD0hhCmaWvqNhTnf07s2Kqhkru_nyySX-ZAjqRz6675u4tlZlFi1huKGXA2aFcS_l4BXlvmralGqtj","Customer":{"CardNumber":"","CardStartMonth":"","CardStartYear":"","CardIssueNumber":"","CardName":"","CardExpiryMonth":"","CardExpiryYear":"","IsActive":false,"TokenCustomerID":null,"Reference":"","Title":"Mr.","FirstName":"John","LastName":"Smith","CompanyName":"SmartOSC","JobDescription":"Java Developer","Street1":"Level 5","Street2":"369 Queen Street","City":"Sydney","State":"NSW","PostalCode":"2000","Country":"au","Email":"","Phone":"0123456789","Mobile":"0123456789","Comments":"","Fax":"1234","Url":"http://www.ewaypayments.com"},"Payment":{"TotalAmount":1000,"InvoiceNumber":"Inv 21540","InvoiceDescription":"Individual Invoice Description","InvoiceReference":"513456","CurrencyCode":"AUD"},"FormActionURL":"https://secure-au.sandbox.ewaypayments.com/Process","CompleteCheckoutURL":null,"Errors":null}'
            error_json = '{"SharedPaymentUrl":null,"AccessCode":null,"Customer":{"CardNumber":null,"CardStartMonth":null,"CardStartYear":null,"CardIssueNumber":null,"CardName":null,"CardExpiryMonth":null,"CardExpiryYear":null,"IsActive":false,"TokenCustomerID":null,"Reference":null,"Title":null,"FirstName":null,"LastName":null,"CompanyName":null,"JobDescription":null,"Street1":null,"Street2":null,"City":null,"State":null,"PostalCode":null,"Country":null,"Email":null,"Phone":null,"Mobile":null,"Comments":null,"Fax":null,"Url":null},"Payment":{"TotalAmount":1000,"InvoiceNumber":"Inv 21540","InvoiceDescription":"Individual Invoice Description","InvoiceReference":"513456","CurrencyCode":"AUD"},"FormActionURL":null,"CompleteCheckoutURL":null,"Errors":"V6047"}'
            @response = CreateAccessCodeSharedResponse.from_json(json)
            @error_response = CreateAccessCodeSharedResponse.from_json(error_json)
          end

          def test_do_convert
            transaction_response = @convert.do_convert(@response)
            assert_equal(1000, transaction_response.transaction.payment_details.total_amount, 0.001)
            assert_equal('John', transaction_response.transaction.customer.first_name)
          end

          def test_error
            error_transaction_response = @convert.do_convert(@error_response)
            assert(error_transaction_response.errors.include?('V6047'))
          end

          def teardown; end
        end
      end
    end
  end
end