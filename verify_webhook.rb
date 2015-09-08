require 'rubygems'
require 'base64'
require 'openssl'
require 'sinatra'

SHARED_SECRET = '5ddb579b-e110-408b-8795-6fb0585adc72'

set :port, 3000

helpers do
  def verify_webhook(data, hmac_header)
    digest = OpenSSL::Digest.new('sha256')
    sha = OpenSSL::HMAC.digest(digest, SHARED_SECRET, data)
    calculated_hmac = Base64.encode64(sha).strip
    calculated_hmac == hmac_header
  end
end


post '/' do
  data = request.body.read
  hmac_header = request.env["HTTP_HTTP_X_RTB_CUSTOMER_HMAC_SHA256"]
  verified = verify_webhook(data, hmac_header)

  puts "Webhook verified: #{verified}"
end
