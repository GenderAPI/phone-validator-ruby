# frozen_string_literal: true

require "httparty"
require "json"

module PhoneValidator
  ##
  # PhoneValidator::Client
  #
  # Ruby SDK for the Phone Number Validation & Formatter API provided by [GenderAPI](https://www.genderapi.io).
  #
  # This class allows you to:
  # - Validate international phone numbers
  # - Detect number type (mobile, landline, VoIP, etc.)
  # - Retrieve region and country metadata
  # - Format numbers to E.164 or national format
  #
  # @example Basic usage
  #   client = PhoneValidator::Client.new(api_key: "your_api_key")
  #   result = client.validate(number: "+1 212 867 5309", address: "US")
  #   puts result["e164"]
  #
  class Client
    include HTTParty
    base_uri "https://api.genderapi.io"

    ##
    # Initializes a new client instance.
    #
    # @param api_key [String] Your GenderAPI API key as a Bearer token.
    # @param base_url [String] Optional override for the base URL (defaults to api.genderapi.io).
    #
    def initialize(api_key:, base_url: nil)
      @api_key = api_key
      self.class.base_uri(base_url) if base_url
      @headers = {
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type" => "application/json"
      }
    end

    ##
    # Validates and formats a phone number.
    #
    # @param number [String] Phone number in any format (required).
    # @param address [String] Optional. Country code (e.g., 'US'), full country name, or city name to improve accuracy.
    #
    # @return [Hash] The parsed JSON response as a Ruby Hash.
    #
    # @example Validate number
    #   client.validate(number: "+1 212 867 5309", address: "US")
    #
    def validate(number:, address: "")
      payload = {
        number: number,
        address: address
      }

      _post_request("/api/phone", payload)
    end

    private

    ##
    # Internal helper to POST a request to the API and parse the result.
    #
    # @param endpoint [String] API endpoint path (e.g. "/api/phone").
    # @param payload [Hash] Request body to be sent as JSON.
    #
    # @return [Hash] Parsed JSON response.
    #
    def _post_request(endpoint, payload)
      cleaned_payload = payload.reject { |_k, v| v.nil? }

      response = self.class.post(
        endpoint,
        headers: @headers,
        body: JSON.generate(cleaned_payload)
      )

      if [500, 502, 503, 504, 408].include?(response.code)
        raise "GenderAPI Server Error or Timeout: HTTP #{response.code} - #{response.body}"
      else
        begin
          parse_json(response.body)
        rescue JSON::ParserError
          raise "GenderAPI Response is not valid JSON"
        end
      end
    rescue HTTParty::Error => e
      raise "GenderAPI Request failed: #{e.message}"
    end

    ##
    # Safely parses a JSON string to a Ruby Hash.
    #
    # @param body [String] Raw JSON response.
    # @return [Hash] Parsed JSON as Hash.
    #
    def parse_json(body)
      JSON.parse(body)
    end
  end
end
