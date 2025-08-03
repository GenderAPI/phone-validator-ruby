require 'phonevalidator'

client = PhoneValidator::Client.new(api_key: "YOUR_API_KEY")

result = client.validate(number: "+14155552671")
puts result
