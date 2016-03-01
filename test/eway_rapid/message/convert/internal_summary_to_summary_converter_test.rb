require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class InternalSummaryToSummaryConverterTest < TestBase

        def setup
          @convert = InternalSummaryToSummary.new
        end

        def test_do_convert
          internal_summary = ObjectCreator.create_settlement_summary
          internal_summary.balance_per_card_type = [ObjectCreator.create_balance]
          summary = @convert.do_convert(internal_summary)
          assert_equal('53e78b14-ac2c-4b1b-a099-a12c6d5f30bc', summary.settlement_id)
          assert_equal('AUD', summary.currency_code)
          assert_equal(14, summary.balance_per_card_type.first.number_of_transactions)
        end

        def teardown

        end
      end
    end
  end
end