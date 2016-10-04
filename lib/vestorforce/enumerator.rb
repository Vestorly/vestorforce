module Vestorforce
  module Enumerator
    attr_reader :mapper

    def initialize(mapper = BaseMapper.new)
      @mapper = mapper
    end

    def enumerate(collection)
      collection.each_with_index do |item, index|
        yield mapper.map(item)
      end
    end
  end
end
