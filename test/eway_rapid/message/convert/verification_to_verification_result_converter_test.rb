require_relative '../../../test_base'

module EwayRapid
  module Message
    module Convert
      class VerificationToVerificationResultConverterTest < TestBase

        def setup
          @convert = VerificationToVerificationResult.new
        end

        def test_do_convert
          verification = ObjectCreator.create_verification
          vr = @convert.do_convert(verification)
          assert_equal(Enums::VerifyStatus::UNCHECKED, vr.cvn)
        end

        def test_invalid_status
          verification = ObjectCreator.create_verification
          verification.address = 'a'
          result = @convert.do_convert(verification)
          assert_equal(result.address, nil)
        end

        def teardown; end
      end
    end
  end
end