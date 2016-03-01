module EwayRapid
  module Message
    module Convert
      class InternalSettlementToSettlement

        # @param [InternalModels::SettlementTransaction] i_settlement
        # @return [Models::SettlementTransaction]
        def do_convert(i_settlement)
          settlement = Models::SettlementTransaction.new
          settlement.settlement_id = i_settlement.settlement_id
          settlement.eway_customer_id = i_settlement.eway_customer_id
          settlement.currency = i_settlement.currency
          settlement.currency_code = i_settlement.transaction_id
          settlement.transaction_id = i_settlement.transaction_id
          settlement.txn_reference = i_settlement.txn_reference
          settlement.card_type = i_settlement.card_type
          settlement.amount = i_settlement.amount
          settlement.transaction_type = i_settlement.transaction_type
          settlement.transaction_date = Time.at(i_settlement.transaction_date.delete('^0-9').to_i / 1000.0 )
          settlement.settlement_date = Time.at(i_settlement.settlement_date.delete('^0-9').to_i / 1000.0 )
          settlement
        end

      end
    end
  end
end
