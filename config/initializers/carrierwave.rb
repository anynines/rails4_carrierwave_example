require 'carrierwave'
require 'a9s_swift'

BUCKET_NAME = "images"

if Rails.env.production?
  Anynines::Swift::Utility.configure_carrierwave(BUCKET_NAME,{fog_public: false}, "openstack")
end
