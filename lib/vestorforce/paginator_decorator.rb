module Vestorforce
  class PaginatorDecorator < SimpleDelegator
    attr_reader :date, :page_size
    def initialize(query, date: nil, page_size: 1000)
      @date = date
      @page_size = page_size
      @query = query
      super(@query)
    end

    def prepare_query(last_id: nil)
      greater_than_id = last_id ? " and (Id > '#{last_id}')" : ''
      greater_than_date = @date ? " and (CreatedDate > #{date})" : ''

      constraints = " and (email <>'' or email <> NULL)" \
        "#{greater_than_date}" \
        " #{greater_than_id}ORDER BY Id" \
        " LIMIT #{page_size}"
      @query + constraints
    end
  end
end
