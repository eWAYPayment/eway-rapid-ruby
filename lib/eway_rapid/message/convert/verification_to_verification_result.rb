module EwayRapid
  module Message
    module Convert
      class VerificationToVerificationResult

        # @param [InternalModels::Verification] verification
        def do_convert(verification)
          result = Models::VerificationResult.new

          if verification
            result.address = get_verify_status(verification.address)
            result.cvn = get_verify_status(verification.cvn)
            result.email = get_verify_status(verification.email)
            result.mobile = get_verify_status(verification.mobile)
            result.phone = get_verify_status(verification.mobile)
          end
          result
        end

        # @param [String] status
        # @return [String]
        def get_verify_status(status)
          begin
            index = Integer(status)
            Enums::VerifyStatus.calculate_status(index)
          rescue StandardError
            return nil
          end
        end
      end
    end
  end
end
