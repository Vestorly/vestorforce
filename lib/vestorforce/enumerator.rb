module Vestorforce
  class Enumerator
    attr_reader :mapper

    def initialize(mapper = BaseMapper.new)
      @mapper = mapper
    end

    def enumerate(collection)
      collection.each_with_index do |item, index|
        mapper.call(item)
      end
    end
  end
end
