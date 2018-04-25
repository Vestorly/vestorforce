module Vestorforce
  class BatchArray

    attr_reader :current_batch

    def initialize(query:, client:, index: 0, batch_size: 50)
      @query = query
      @client = client
      @index = index
      @batch_size = batch_size

      set_batch
    end

    def batch_each
      while current_batch.size > 0 && @index < 2500
        current_batch.each do |item|
          yield(item)
        end

        @index += @batch_size
        set_batch
      end
    end

    private

    def set_batch
      query_constraints =
        'ORDER BY Id ' \
        "OFFSET #{@index} " \
        "LIMIT #{@batch_size}"

      @current_batch = @client.query(@query + query_constraints)
    end
  end
end
