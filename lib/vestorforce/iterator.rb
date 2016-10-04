module Vestorforce
  class Iterator
    def initialize(enumerator, query, client, page_size: 1000)
      last_id = nil
      begin
        paged_query = query(last_id: last_id)
        items = client.query(paged_query).to_a
        break if items.empty?
        last_id = items.last.Id
        enumerator(items)
      end while items == page_size
    end
  end
end
