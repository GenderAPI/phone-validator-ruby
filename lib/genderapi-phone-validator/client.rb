# frozen_string_literal: true

require "httparty"
require "json"

module PhoneValidator
  ##
  # Ruby SDK for Phone Number Validation & Formatter API from www.genderapi.io
  #
  # This SDK allows you to:
  #   - Validate international phone numbers
  #   - Detect number type (mobile, landline, VoIP, etc.)
  #   - Retrieve region and country metadata
  #   - Format numbers to E.164 or national format
  #
  # Learn more: https://www.genderapi.io
  #
  class Client
    include HTTParty
    base_uri "https://api.genderapi.io"

    ##
    # Initialize the PhoneValidator client.
    #
    # @param api_key [String] Your GenderAPI API key as a Bearer token.
    # @param base_url [String] Optional override for the API base URL.
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
    # Validate and format a phone number.
    #
    # @param number [String] The phone number to validate (required).
    # @param address [String] Optional address or country hint for better accuracy.
    #
    # @return [Hash] Parsed JSON response containing validation results.
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
    # Internal helper for sending POST requests to the GenderAPI.io API.
    #
    # Handles:
    #   - Bearer token authorization
    #   - Payload cleanup (removal of nil values)
    #   - Error handling and JSON parsing
    #
    # @param endpoint [String] API endpoint path (e.g. "/api/phone")
    # @param payload [Hash] Request body
    #
    # @return [Hash] Parsed JSON response
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
    # Safely parse JSON response.
    #
    # @param body [String] JSON string
    # @return [Hash] Ruby Hash
    #
    def parse_json(body)
      JSON.parse(body)
    end
  end
end
