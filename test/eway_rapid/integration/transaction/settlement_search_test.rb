require_relative '../../../test_base'

class SettlementSearchTest < TestBase

  def setup
    @client = IntegrationTest.get_sandbox_client
  end

  def test_valid_input
    @search = EwayRapid::InputModelFactory.create_settlement_search

    search_response = @client.settlement_search(@search)

    assert(search_response.errors.nil? || search_response.errors.length == 0)
    assert(!search_response.settlement_transactions.nil? && search_response.settlement_transactions.length > 0)
  end

  def teardown; end
end