require 'vestorforce/version'
require 'vestorforce/api'
require 'vestorforce/queries'
require 'vestorforce/base_mapper'
require 'vestorforce/paginator_decorator'
require 'vestorforce/enumerator'
require 'vestorforce/iterator'

module Vestorforce
  def self.hi
    puts 'hello world!'
  end

  def self.client(config)
    Api.new(config)
  end
end
