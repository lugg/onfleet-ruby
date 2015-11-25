module Onfleet
  module Errors
    class Error < StandardError
      attr_reader :code,
                  :error,
                  :message,
                  :docs,
                  :request_id,
                  :cause,
                  :http_status,
                  :http_body,
                  :http_headers,
                  :json_body,
                  :nestful_error

      def initialize(options = {})
        @code          = options[:code]
        @error         = options[:error]
        @message       = options[:message]
        @docs          = options[:docs]
        @request_id    = options[:request_id]
        @cause         = options[:cause]
        @http_status   = options[:http_status]
        @http_body     = options[:http_body]
        @http_headers  = options[:http_headers]
        @json_body     = options[:json_body]
        @nestful_error = options[:nestful_error]

        super message
      end

      def to_s
        status_string = http_status.nil? ? "" : "(Status #{@http_status}) "
        id_string = @request_id.nil? ? "" : "(Request #{@request_id}) "
        "#{status_string}#{id_string}#{@message}"
      end
    end

    class InvalidContent < Error; end
    class InvalidCredentials < Error; end
    class ResourceNotFound < Error; end
    class InvalidArgument < Error; end
    class PreconditionFailed < Error; end
    class InternalError < Error; end
  end
end
