module Vestorforce
  class BatchArray

    attr_reader :current_batch

    def initialize(query:, client:, date: nil, offset: 0, batch_size: 50)
      @query = query
      @client = client
      @date = date
      @offset = offset
      @batch_size = batch_size

      set_batch
    end

    def batch_each
      while current_batch.size > 0
        current_batch.each do |item|
          yield(item)
        end

        @offset += @batch_size
        set_batch
      end
    end

    private

    def set_batch
      date_constraint = @date ? "and (CreatedDate > #{@date} " : ''
      query_constraints =
        'ORDER BY Id ' \
        "LIMIT #{@batch_size} " \
        "OFFSET #{@offset}"

      @current_batch = @client.query(@query + date_constraint + query_constraints)
    end
  end
end
