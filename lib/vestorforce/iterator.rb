module Vestorforce
  class Iterator
    attr_reader :enumerator, :query, :client
    def initialize(enumerator, query, client)
      @enumerator = enumerator
      @query = query
      @client = client
    end

    def iterate
      last_id = nil
      items = []
      begin
        paged_query = query.prepare_query(last_id: last_id)
        items = client.query(paged_query).to_a
        last_id = last_id_from_items(items)
        enumerator.enumerate(items)
      end while !last_id.nil? && (!items.nil? && !items.empty?)
    end

    def last_id_from_items(items)
      return if items.last.nil?
      return if !items.last.respond_to?(:Id)
      items.last.Id
    end
  end
end
