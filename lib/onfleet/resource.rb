require "json"
require "active_support/core_ext/hash"

module Onfleet
  class Resource < Mash
    def self.endpoint(value = nil)
      @endpoint = value if value
      return @endpoint if @endpoint
      superclass.respond_to?(:endpoint) ? superclass.endpoint : nil
    end

    def self.path(value = nil)
      @path = value if value
      return @path if @path
      superclass.respond_to?(:path) ? superclass.path : nil
    end

    def self.options(value = nil)
      @options ||= {}
      @options.merge!(value) if value

      if superclass.respond_to?(:options)
        Nestful::Helpers.deep_merge(superclass.options, @options)
      else
        @options
      end
    end

    class << self
      alias_method :endpoint=, :endpoint
      alias_method :path=, :path
      alias_method :options=, :options
      alias_method :add_options, :options
    end

    def self.url
      URI.join(endpoint.to_s, path.to_s).to_s
    end

    def self.uri(*parts)
      if (uri = parts.first) && uri.is_a?(URI)
        return uri if uri.host
      end

      value = Nestful::Helpers.to_path(url, *parts)

      URI.parse(value)
    end

    OPTION_KEYS = %i{
      params key headers stream
      proxy user password auth_type
      timeout ssl_options request
    }

    def self.parse_values(values)
      params  = values.reject { |k, _| OPTION_KEYS.include?(k) }
      options = values.select { |k, _| OPTION_KEYS.include?(k) }

      if request_options = options.delete(:request)
        options.merge!(request_options)
      end

      [params, options]
    end

    def self.get(action = "", values = {})
      params, options = parse_values(values)

      request(
        uri(action),
        options.merge(method: :get, params: params, format: :json))
    end

    def self.put(action = "", values = {})
      params, options = parse_values(values)

      request(
        uri(action),
        options.merge(method: :put, params: params, format: :json))
    end

    def self.post(action = "", values = {})
      params, options = parse_values(values)

      request(
        uri(action),
        options.merge(method: :post, params: params, format: :json))
    end

    def self.delete(action = "", values = {})
      params, options = parse_values(values)

      request(
        uri(action),
        options.merge(method: :delete, params: params))
    end

    def self.request(uri, options = {})
      options = Nestful::Helpers.deep_merge(self.options, options)

      begin
        response = Nestful::Request.new(
          uri, options
        ).execute
      rescue JSON::ParserError
        raise Errors::Error
      rescue Nestful::ResponseError => e
        handle_response_error(e)
      rescue Nestful::Error => e
        handle_error(e)
      end

      response
    end

    def self.handle_error(nestful_error)
      raise Errors::Error, message: nestful_error.message, nestful_error: nestful_error
    end

    def self.handle_response_error(nestful_error)
      response = nestful_error.response

      begin
        error = JSON.parse(response.body)
        error = error.with_indifferent_access if error
        raise Errors::Error unless error && error.is_a?(Hash)
      rescue JSON::ParserError, Errors::Error
        raise general_error(response.code, response.body)
      end

      err_args = [error, response, nestful_error]

      case response.code
      when "400"
        raise create_error Errors::InvalidContent, *err_args
      when "401"
        raise create_error Errors::InvalidCredentials, *err_args
      when "404"
        raise create_error Errors::ResourceNotFound, *err_args
      when "409"
        raise create_error Errors::InvalidArgument, *err_args
      when "412"
        raise create_error Errors::PreconditionFailed, *err_args
      when "429"
        raise create_error Errors::TooManyRequests, *err_args
      when "500"
        raise create_error Errors::InternalError, *err_args
      else
        raise create_error Errors::OnfleetError, *err_args
      end
    end

    def self.general_error(response_code, response_body)
      Errors::Error.new(
        message: "Invalid response object from API: #{response_body.inspect} " + "(HTTP response code was #{response_code})",
        http_status: response_code,
        http_body: response_body
      )
    end

    def self.create_error(klass, error, response, nestful_error)
      options = error_options(error, response, nestful_error)
      klass.new(options)
    end

    def self.error_options(onfleet_error, response, nestful_error)
      onfleet_message = onfleet_error[:message]

      options = {
        message: (onfleet_message[:message] || response.body).to_s,
        http_status: response.code,
        http_body: response.body,
        http_headers: response.header.to_hash,
        json_body: onfleet_error,
        nestful_error: nestful_error
      }

      if onfleet_message.is_a?(Hash)
        options.merge(
          code: onfleet_message[:code],
          error: onfleet_message[:error],
          docs: onfleet_message[:docs],
          request_id: onfleet_message[:request],
          cause: onfleet_message[:cause]
        )
      else
        options
      end
    end

    def uri(*parts)
      self.class.uri(*[id, *parts].compact)
    end
  end
end
