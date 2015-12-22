require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Response
        class AccessCodeSharedToCreateCustConverterTest < TestBase
          def setup
            @convert = AccessCodeSharedToCreateCust.new
            json = '{
                      "SharedPaymentUrl": "https://secure-au.sandbox.ewaypayments.com/sharedpage/sharedpayment?AccessCode=44DD7aVwPYUPemGRf7pcWxyX2FJS-0Wk7xr9iE7Vatk_5vJimEbHveGSqX52B00QsBXqbLh9mGZxMHcjThQ_ITsCZ3JxKOY88WOVsFTLPrGtHRkK0E9ZDVh_Wz326QZlNlwx2",
                      "AccessCode": "44DD7aVwPYUPemGRf7pcWxyX2FJS-0Wk7xr9iE7Vatk_5vJimEbHveGSqX52B00QsBXqbLh9mGZxMHcjThQ_ITsCZ3JxKOY88WOVsFTLPrGtHRkK0E9ZDVh_Wz326QZlNlwx2",
                      "Customer": {
                          "CardNumber": "",
                          "CardStartMonth": "",
                          "CardStartYear": "",
                          "CardIssueNumber": "",
                          "CardName": "",
                          "CardExpiryMonth": "",
                          "CardExpiryYear": "",
                          "IsActive": false,
                          "TokenCustomerID": null,
                          "Reference": "A12345",
                          "Title": "Mr.",
                          "FirstName": "John",
                          "LastName": "Smith",
                          "CompanyName": "Demo Shop 123",
                          "JobDescription": "Developer",
                          "Street1": "Level 5",
                          "Street2": "369 Queen Street",
                          "City": "Sydney",
                          "State": "NSW",
                          "PostalCode": "2000",
                          "Country": "au",
                          "Email": "demo@example.org",
                          "Phone": "09 889 0986",
                          "Mobile": "09 889 6542",
                          "Comments": "",
                          "Fax": "",
                          "Url": "http://www.ewaypayments.com"
                      },
                      "Payment": {
                          "TotalAmount": 1000,
                          "InvoiceNumber": "Inv 21540",
                          "InvoiceDescription": "Individual Invoice Description",
                          "InvoiceReference": "513456",
                          "CurrencyCode": "AUD"
                      },
                      "FormActionURL": "https://secure-au.sandbox.ewaypayments.com/AccessCode/44DD7aVwPYUPemGRf7pcWxyX2FJS-0Wk7xr9iE7Vatk_5vJimEbHveGSqX52B00QsBXqbLh9mGZxMHcjThQ_ITsCZ3JxKOY88WOVsFTLPrGtHRkK0E9ZDVh_Wz326QZlNlwx2",
                      "CompleteCheckoutURL": null,
                      "Errors": null
                  }'
            @response = CreateAccessCodeSharedResponse.from_json(json)
          end

          def test_do_convert
            customer_res = @convert.do_convert(@response)
            assert_equal('John', customer_res.customer.first_name)
            assert_equal('Level 5', customer_res.customer.address.street1)
          end

          def teardown

          end
        end
      end
    end
  end
end