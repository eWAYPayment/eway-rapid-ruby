require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Response
        class SearchToQueryTransConverterTest < TestBase
          def setup
            @convert = SearchToQueryTrans.new
            json = '{"Transactions":[{"AuthorisationCode":"607313","ResponseCode":"00","ResponseMessage":"A2000","InvoiceNumber":"Inv 21540","InvoiceReference":"513456","TotalAmount":1000,"TransactionID":11735670,"TransactionStatus":true,"TokenCustomerID":null,"BeagleScore":0,"Options":[],"Verification":{"CVN":0,"Address":0,"Email":0,"Mobile":0,"Phone":0},"BeagleVerification":{"Email":0,"Phone":0},"Customer":{"TokenCustomerID":null,"Reference":null,"Title":null,"FirstName":"John","LastName":"Smith","CompanyName":null,"JobDescription":null,"Street1":"Level 5","Street2":"369 Queen Street","City":"Sydney","State":"NSW","PostalCode":"2000","Country":"Au","Email":"","Phone":"0123456789","Mobile":null,"Comments":null,"Fax":null,"Url":null},"CustomerNote":null,"ShippingAddress":{"ShippingMethod":null,"FirstName":"","LastName":"","Street1":"Level 5","Street2":"369 Queen Street","City":"Sydney","State":"NSW","Country":"Au","PostalCode":"2000","Email":"","Phone":"","Fax":null}}],"Errors":""}'
            @response = TransactionSearchResponse.from_json(json)
          end

          def test_do_convert
            res = @convert.do_convert(@response)
            assert_equal(1000, res.transaction.payment_details.total_amount, 0.001)
            assert_equal(0, res.transaction_status.beagle_score, 0.001)
          end

          def teardown; end
        end
      end
    end
  end
end