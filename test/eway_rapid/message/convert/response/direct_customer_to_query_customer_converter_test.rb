require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Response
        class DirectCustomerToQueryCustomerConverterTest < TestBase

          def setup
            @convert = DirectCustomerToQueryCustomer.new
            json = '{"Customers":[{"CardDetails":{"Number":"444433XXXXXX1111","Name":"John Smith","ExpiryMonth":"12","ExpiryYear":"25","StartMonth":"","StartYear":"","IssueNumber":""},"TokenCustomerID":912981244527,"Reference":"","Title":"Mr.","FirstName":"John","LastName":"Smith","CompanyName":"eWAY","JobDescription":"Ruby Developer","Street1":"Level 5, 369 Queen Street","Street2":null,"City":"Sydney","State":"NSW","PostalCode":"2000","Country":"Au","Email":"","Phone":"0123456789","Mobile":"0123456789","Comments":"","Fax":"1234","Url":"http://www.ewaypayments.com"}],"Errors":null}'
            error_json = '{"Customers":[],"Errors":"V6040"}'
            @response = DirectCustomerSearchResponse.from_json(json)
            @error_response = DirectCustomerSearchResponse.from_json(error_json)
          end

          def test_do_convert
            customer_response = @convert.do_convert(@response)
            assert_equal('12',customer_response.card_detail.expiry_month)
            assert_equal('John', customer_response.first_name)
            assert_equal('Sydney', customer_response.city)
          end

          def test_error
            customer_res = @convert.do_convert(@error_response)
            assert(customer_res.errors[0].include?('V6040'))
          end

          def teardown; end
        end
      end
    end
  end
end