module Vestorforce
  class Enumerator
    attr_reader :mapper

    def initialize(mapper = BaseMapper.map)
      @mapper = mapper
    end

    def enumerate(collection)
      collection.map.with_index do |item, index|
        mapper.call(item)
      end
    end
  end
end
