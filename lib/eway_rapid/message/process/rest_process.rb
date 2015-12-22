module EwayRapid
  module Message
    module RestProcess

      # Call restful web service with post method
      #
      # @param [String] url rapid endpoint url
      # @param [String] api_key rapid api key
      # @param [String] password rapid password
      # @param [String] request object to post
      def do_post(url, api_key, password, request)
        begin
          RestClient::Request.execute(
            :method => :post,
            :url => url,
            :user => api_key,
            :password => password,
            :payload => request.to_json,
            :timeout => 9000000,
            :headers => {
                :accept => :json,
                :content_type => :json,
                :user_agent => get_user_agent
            }
          )
        rescue SocketError => e
          raise Exceptions::CommunicationFailureException.new(e.to_s)
        rescue RestClient::Exception => e
          if e.http_code == 401 || e.http_code == 403 || e.http_code == 404
            raise Exceptions::AuthenticationFailureException.new(e.to_s)
          else
            raise Exceptions::SystemErrorException.new(e.to_s)
          end
        end
      end

      # Call restful web service with get method
      #
      # @param [String] url rapid endpoint url
      # @param [String] api_key rapid api key
      # @param [String] password rapid password
      def do_get(url, api_key, password)
        begin
          RestClient::Request.new(
              :method => :get,
              :url => url,
              :user => api_key,
              :password => password,
              :headers => {
                  :accept => :json,
                  :content_type => :json,
                  :user_agent => get_user_agent
              }
          ).execute
        rescue SocketError => e
          raise Exceptions::CommunicationFailureException.new(e.to_s)
        rescue RestClient::Exception => e
          if e.http_code == 401 || e.http_code == 403 || e.http_code == 404
            raise Exceptions::AuthenticationFailureException.new(e.to_s)
          else
            raise Exceptions::SystemErrorException.new(e.to_s)
          end
        end
      end

      private

      def get_user_agent
        begin
          property_array = YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', 'resources', 'rapid-api.yml'))
          property_array.each do |h|
            if Constants::RAPID_SDK_USER_AGENT_PARAM == h.keys.first
              if h[h.keys.first]
                return "#{h[h.keys.first]} #{EwayRapid::VERSION}"
              else
                fail "Rapid endpoint '#{Constants::RAPID_API_RESOURCE}' is invalid."
              end
            end
          end
        rescue => e
          @logger.error "Error loading user agent parameter #{e}" if @logger
        end
        ''
      end
    end
  end
end
