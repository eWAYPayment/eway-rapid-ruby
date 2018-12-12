require_relative '../../../lib/eway_rapid'

class IntegrationTest
  PASSWORD = 'API-P4ss'
  API_KEY = '60CF3Ce97nRS1Z1Wp5m9kMmzHHEh8Rkuj31QCtVxjPWGYA9FymyqsK0Enm1P6mHJf0THbR'
  SANDBOX_ENDPOINT = 'https://api.sandbox.ewaypayments.com/'

  # @return [RapidClient]
  def self.get_sandbox_client
    client = EwayRapid::RapidClient.new(API_KEY, PASSWORD, SANDBOX_ENDPOINT)
    client.set_version(IntegrationTest.get_version)
    client
  end

  def self.get_version
    if (ENV["EWAY_API_VERSION"])
      return ENV["EWAY_API_VERSION"].to_i
    else
      return 31;
    end
  end
end
