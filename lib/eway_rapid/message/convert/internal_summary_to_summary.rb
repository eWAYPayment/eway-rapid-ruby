module EwayRapid
  module Message
    module Convert
      class InternalSummaryToSummary

        # @param [InternalModels::SettlementSummary] i_summary
        # @return [Models::SettlementSummary]
        def do_convert(i_summary)
          summary = Models::SettlementSummary.new
          summary.settlement_id = i_summary.settlement_id
          summary.currency = i_summary.currency
          summary.currency_code = i_summary.currency_code
          summary.total_credit = i_summary.total_credit
          summary.total_debit = i_summary.total_debit
          summary.total_balance = i_summary.total_balance
          summary.balance_per_card_type = []
          i_summary.balance_per_card_type.each {|balance|
            obj = get_balance(balance)
            summary.balance_per_card_type.push(obj)
          }
          summary
        end

        # @param [InternalModels::BalancePerCardType] i_balance
        # @return [Models::BalancePerCardType]
        def get_balance(i_balance)
          balance =  Models::BalancePerCardType.new
          balance.card_type = i_balance.card_type
          balance.number_of_transactions = i_balance.number_of_transactions
          balance.credit = i_balance.credit
          balance.debit = i_balance.debit
          balance.balance = i_balance.balance
          balance
        end

      end
    end
  end
end
