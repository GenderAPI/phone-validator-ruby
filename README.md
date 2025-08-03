# 📞 Phone Number Validation & Formatter API (Ruby SDK)

The `phonevalidator` gem uses the official [GenderAPI Phone Number Validation & Formatter API](https://www.genderapi.io/) to validate and format phone numbers from over 240 countries and territories.

Whether your users enter phone numbers in various formats (e.g., `12128675309`, `+1 212 867 5309`, `001-212-867-5309`), this library will intelligently detect, validate, and convert the input into a standardized E.164 format (e.g., `+12128675309`).

---

## ✅ Features

- Converts phone numbers to **E.164** format
- Validates if the number is real and structurally possible
- Detects number type: **mobile**, **landline**, **VoIP**, etc.
- Identifies region/city based on area code
- Returns country-level metadata (e.g., ISO code)
- Built with Ruby, uses `HTTParty` for HTTP requests

---

## 📦 Installation

Add the gem to your project:

```bash
gem install genderapi-phone-validator
```

Or in your `Gemfile`:

```ruby
gem 'genderapi-phone-validator'
```

---

## 🔐 Authentication

You need an API key from [www.genderapi.io](https://www.genderapi.io).  
Sign up and get your key from your dashboard.

---

## 🚀 Usage

```ruby
require 'genderapi-phone-validator'

client = PhoneValidator::Client.new(api_key: "YOUR_API_KEY")

response = client.validate(
  number: "+1 212 867 5309",   # Required
  address: "US"                # Optional, helps with local formats
)

puts response
```

---

## 🧾 Input Parameters

```ruby
validate(number:, address: nil) → Hash
```

| Parameter | Type   | Required | Description |
|-----------|--------|----------|-------------|
| `number`  | String | ✅ Yes   | Phone number in any format |
| `address` | String | Optional | ISO country code (`US`), full country name (`Turkey`), or city name (`Berlin`) – improves local number detection |

#### Example:

```ruby
client.validate(number: "2128675309", address: "US")
```

---

## 📬 API Response Example

```json
{
  "status": true,
  "remaining_credits": 15709,
  "expires": 0,
  "duration": "18ms",
  "regionCode": "US",
  "country": "United States",
  "national": "(212) 867-5309",
  "international": "+1 212-867-5309",
  "e164": "+12128675309",
  "isValid": true,
  "isPossible": true,
  "numberType": "FIXED_LINE_OR_MOBILE",
  "nationalSignificantNumber": "2128675309",
  "rawInput": "+1 212 867 5309",
  "isGeographical": true,
  "areaCode": "212",
  "location": "New York City (Manhattan)"
}
```

---

## 🧠 Response Field Reference

| Field                    | Type    | Description                                 |
|--------------------------|---------|---------------------------------------------|
| `status`                 | Boolean | Was the request successful                  |
| `remaining_credits`      | Integer | Remaining API credits                       |
| `regionCode`             | String  | ISO 3166-1 alpha-2 code (e.g., `US`)        |
| `country`                | String  | Country name                                |
| `e164`                   | String  | Number formatted to E.164                   |
| `isValid`                | Boolean | Is number valid according to rules          |
| `isPossible`             | Boolean | Is number structurally possible             |
| `numberType`             | String  | Number type (`MOBILE`, `FIXED_LINE`, etc.)  |
| `areaCode`              | String  | Area code from input                        |
| `location`               | String  | City/region matched from area code          |

---

## 🔢 Number Type Values

| Value                  | Description                             |
|------------------------|-----------------------------------------|
| `FIXED_LINE`           | Landline                                |
| `MOBILE`               | Mobile phone                            |
| `FIXED_LINE_OR_MOBILE` | Ambiguous, could be both                |
| `TOLL_FREE`            | e.g., 800 numbers                       |
| `PREMIUM_RATE`         | Expensive premium numbers               |
| `SHARED_COST`          | Cost shared between parties             |
| `VOIP`                 | Internet-based phone                    |
| `PERSONAL_NUMBER`      | Forwarding number                       |
| `PAGER`                | Obsolete pager number                   |
| `VOICEMAIL`            | Voicemail access                        |
| `UNKNOWN`              | Cannot be determined                    |

---

## ℹ️ More Information

- Supports **240+ countries and territories**
- Automatically detects mobile vs. landline
- Useful for CRMs, forms, messaging, marketing, and more
- Full documentation at: [https://www.genderapi.io/docs-phone-validation-formatter-api](https://www.genderapi.io/docs-phone-validation-formatter-api)

---

## 📝 License

MIT License © [GenderAPI](https://www.genderapi.io)
