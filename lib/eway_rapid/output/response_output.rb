module EwayRapid
  # Base class for the output data class inherits
  class ResponseOutput

    # List of all validation, processing, fraud or system errors that occurred
    # when processing this request.
    attr_accessor :errors

    def initialize(*args, &block)
      super
      @errors = []
    end
  end
end
