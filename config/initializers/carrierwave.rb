require 'json'

BUCKET_NAME = "images"

# create the bucket if there are no directories within the Swift container
# uses a direct fog connection
def create_bucket_if_needed(swift_service)
  connection = Fog::Storage.new({
     :provider => 'HP',
     :hp_access_key => swift_service["credentials"]["user_name"],
     :hp_secret_key => swift_service["credentials"]["password"],
     :hp_tenant_id => swift_service["credentials"]["tenant_id"],
     :hp_auth_uri => swift_service["credentials"]["authentication_uri"],
     :hp_use_upass_auth_style => true,
     :hp_avl_zone => swift_service["credentials"]["availability_zone"]
  })

  if connection.directories.get(BUCKET_NAME).nil?
    puts "The bucket with key=#{BUCKET_NAME} wasn't found. Creating bucket with key=#{BUCKET_NAME}"
    bucket = connection.directories.create key: BUCKET_NAME 

    # set the directory to be public
    bucket.public = true
    bucket.save
    
    connection = nil
  end
end

if Rails.env.production?
  # parse the VCAP_SERVICES environment variable
  SERVICES = JSON.parse(ENV["VCAP_SERVICES"])  
  swift_service = SERVICES["swift-1.0"].first

  create_bucket_if_needed(swift_service)
    
  CarrierWave.configure do |config|
    config.fog_credentials = {
            :provider => 'HP',
            :hp_access_key => swift_service["credentials"]["user_name"],
            :hp_secret_key => swift_service["credentials"]["password"],
            :hp_tenant_id => swift_service["credentials"]["tenant_id"],
            :hp_auth_uri => swift_service["credentials"]["authentication_uri"],
            :hp_use_upass_auth_style => true,
            :hp_avl_zone => swift_service["credentials"]["availability_zone"]
          }
    
    config.fog_directory  = BUCKET_NAME                     # required
    config.fog_public     = true                                   # optional, defaults to true
  end
end

