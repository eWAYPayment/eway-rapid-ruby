require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class InternalSettlementToSettlementConverterTest < TestBase

        def setup
          @convert = InternalSettlementToSettlement.new
        end

        def test_do_convert
          internal_tran = ObjectCreator.create_settlement_transaction
          tran = @convert.do_convert(internal_tran)
          assert_equal('53e78b14-ac2c-4b1b-a099-a12c6d5f30bc', tran.settlement_id)
          assert_equal('VI', tran.card_type)
          assert_true(tran.transaction_date.is_a?(Time))
        end

        def teardown

        end
      end
    end
  end
end