module Onfleet
  module Errors
    class Error < StandardError
      attr_reader :message,
                  :http_status,
                  :http_body,
                  :http_headers,
                  :json_body,
                  :nestful_error

      def initialize(options = {})
        @message       = options[:message]
        @http_status   = options[:http_status]
        @http_body     = options[:http_body]
        @http_headers  = options[:http_headers]
        @json_body     = options[:json_body]
        @nestful_error = options[:nestful_error]
      end

      def to_s
        status_string = http_status.nil? ? "" : "(Status #{http_status}) "
        "#{status_string}#{message}"
      end
    end

    class OnfleetError < Error
      attr_reader :code,
                  :error,
                  :docs,
                  :request_id,
                  :cause

      def initialize(options = {})
        @code          = options[:code]
        @error         = options[:error]
        @docs          = options[:docs]
        @request_id    = options[:request_id]
        @cause         = options[:cause]

        super(options)
      end

      def to_s
        code_string = code.nil? ? "" : "(Status #{code}) "
        id_string = request_id.nil? ? "" : "(Request #{request_id}) "
        "#{code_string}#{id_string}#{message}"
      end
    end

    # https://gist.github.com/euskode/8a34b2152cb35ddeb659
    class InvalidContent < OnfleetError; end
    class InvalidCredentials < OnfleetError; end
    class ResourceNotFound < OnfleetError; end
    class InvalidArgument < OnfleetError; end
    class PreconditionFailed < OnfleetError; end
    class TooManyRequests < OnfleetError; end
    class InternalError < OnfleetError; end
  end
end
