require 'simplecov'
require 'simplecov-gem-adapter'
# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
end

ENV['oath_token'] = "00Df40000038It7!ARwAQLyw1KeM6jo6VzLSoQIBwY0lD9Oz_KOsrpFlg5k4en8uKaRSV.t9K9crzPXN7AGCUMoG4PN93fm8Nf0FZlTo0l4E0SL0"
ENV['instance_url'] = "https://na59.salesforce.com"
ENV['refresh_token'] = "5Aep861UTWIWNgl0kfww2fxNKflArq_mgZazmRYneydBZ9xBVwAKhYvDF6ShOM8z0g7iWWMKIY46_AEIoIpUcn1"
ENV['client_id'] = "3MVG9xOCXq4ID1uFsVRryNv0DilRBlsAlWqRDZ509qpI_VgWyK7IzX3jEyO2cFnHU7w8y2QxuJP_0a4rhZ09n"
ENV['client_secret'] = "1664455320060764720"

SimpleCov.start('gem')

['../lib', './models', '../config'].each do |f|
  $LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), f))
end

require 'vestorforce'
