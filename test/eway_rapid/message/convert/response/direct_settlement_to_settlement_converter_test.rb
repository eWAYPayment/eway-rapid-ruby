require_relative '../../../../test_base'

module EwayRapid
  module Message
    module Convert
      module Response
        class DirectSettlementToSettlementConverterTest < TestBase
          def setup
            @convert = DirectSettlementToSettlement.new
            json = '{"SettlementSummaries":[{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","Currency":"36","CurrencyCode":"AUD","TotalCredit":22400,"TotalDebit":0,"TotalBalance":22400,"BalancePerCardType":[{"CardType":"VI","NumberOfTransactions":11,"Credit":16000,"Debit":0,"Balance":16000},{"CardType":"MC","NumberOfTransactions":1,"Credit":6400,"Debit":0,"Balance":6400}]}],"SettlementTransactions":[{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12189063,"TxnReference":"0000000012189063","CardType":"MC","Amount":6400,"TransactionType":"1","TransactionDateTime":"\/Date(1454371076000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12189930,"TxnReference":"0000000012189930","CardType":"VI","Amount":1000,"TransactionType":"1","TransactionDateTime":"\/Date(1454388043000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12189936,"TxnReference":"0000000012189936","CardType":"VI","Amount":1000,"TransactionType":"1","TransactionDateTime":"\/Date(1454388161000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12189951,"TxnReference":"0000000012189951","CardType":"VI","Amount":2000,"TransactionType":"1","TransactionDateTime":"\/Date(1454388443000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12189953,"TxnReference":"0000000012189953","CardType":"VI","Amount":1000,"TransactionType":"1","TransactionDateTime":"\/Date(1454388462000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12189959,"TxnReference":"0000000012189959","CardType":"VI","Amount":2000,"TransactionType":"1","TransactionDateTime":"\/Date(1454388517000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12189987,"TxnReference":"0000000012189987","CardType":"VI","Amount":2000,"TransactionType":"1","TransactionDateTime":"\/Date(1454389115000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12189998,"TxnReference":"0000000012189998","CardType":"VI","Amount":2000,"TransactionType":"1","TransactionDateTime":"\/Date(1454389263000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12190064,"TxnReference":"0000000012190064","CardType":"VI","Amount":1000,"TransactionType":"1","TransactionDateTime":"\/Date(1454390090000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12190065,"TxnReference":"0000000012190065","CardType":"VI","Amount":1000,"TransactionType":"1","TransactionDateTime":"\/Date(1454390127000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12190129,"TxnReference":"0000000012190129","CardType":"VI","Amount":1000,"TransactionType":"1","TransactionDateTime":"\/Date(1454391143000)\/","SettlementDateTime":"\/Date(1454331600000)\/"},{"SettlementID":"85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0","eWAYCustomerID":91312168,"Currency":"36","CurrencyCode":"AUD","TransactionID":12190141,"TxnReference":"0000000012190141","CardType":"VI","Amount":2000,"TransactionType":"1","TransactionDateTime":"\/Date(1454391459000)\/","SettlementDateTime":"\/Date(1454331600000)\/"}],"Errors":""}'
            @response = DirectSettlementSearchResponse.from_json(json)
          end

          def test_do_convert
            res = @convert.do_convert(@response)
            assert_true(res.settlement_summaries.count > 0)
            assert_equal('85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0', res.settlement_summaries.first.settlement_id)
            assert_equal('VI', res.settlement_summaries.first.balance_per_card_type.first.card_type)
            assert_true(res.settlement_transactions.count > 0)
            assert_equal('85e4c36a-1c2d-4cfc-8b81-ba32caadb6b0', res.settlement_transactions.first.settlement_id)
          end

          def teardown; end
        end
      end
    end
  end
end