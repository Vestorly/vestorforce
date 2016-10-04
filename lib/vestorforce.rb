require 'vestorforce/version'
require 'vestorforce/api'
require 'vestorforce/queries'
module Vestorforce
  def self.hi
    puts 'hello world!'
  end

  def self.client(config)
    Api.new(config)
  end
end
