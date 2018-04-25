require 'vestorforce/version'
require 'vestorforce/api'
require 'vestorforce/queries'
require 'vestorforce/batch_array'

module Vestorforce
  def self.client(config)
    Api.new(config)
  end
end
