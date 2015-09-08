require 'rubygems'
require 'base64'
require 'openssl'
require 'sinatra'

SHARED_SECRET = '0c8819ce-a71a-43b5-a672-5eab36722483'

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
  hmac_header = request.env["HTTP_HTTP_Xhmac_header_RTB_PARTNER_HMAC_SHA256"]
  verified = verify_webhook(data, hmac_header)

  puts "Webhook verified: #{verified}"
end
