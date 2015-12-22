module EwayRapid
  class RapidLogger

    # Creates a new Logger instance for logging
    #
    # @param [String] log_dev a filename (String) or IO object like +STDOUT+, +STDERR+
    def self.init(log_dev)
      @logger = Logger.new(log_dev)
      @logger
    end

    # @return [Logger]
    def self.logger
      conf_log || @logger
    end

    # Check for a logging configuration in rapid_log_config.yml
    def self.conf_log
      prop_name = 'logdev'
      property_array = YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', 'rapid_log_config.yml'))
      property_array.each do |h|
        if prop_name.casecmp(h.keys.first).zero?
          log_dev = h[h.keys.first]
          if !log_dev.nil? && log_dev != ''
            if log_dev.casecmp('stdout').zero?
              return Logger.new(STDOUT)
            elsif log_dev.casecmp('stderr').zero?
              return Logger.new(STDERR)
            else
              return Logger.new(log_dev)
            end
          end
        end
      end
      nil
    rescue
      nil
    end
  end
end
