require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class TransactionToArrLineItemConverterTest < TestBase

        def setup
          @convert = TransactionToArrLineItem.new
        end

        def test_do_convert
          transaction = ObjectCreator.create_transaction
          transaction.line_items = ObjectCreator.create_line_items
          items = @convert.do_convert(transaction)
          assert_equal(1, items.length)
        end

        def test_nil_item
          t = ObjectCreator.create_transaction
          items = @convert.do_convert(t)
          assert(items.length == 0)
        end

        def teardown

        end
      end
    end
  end
end
