module Vestorforce
  class Api
    DEFAULT_SALESFORCE_URL = 'https://na1.salesforce.com'.freeze
    def initialize(opts = {})
      @client = Restforce.new(
        oauth_token:    opts[:oauth_token],
        instance_url:   opts[:instance_url] || DEFAULT_SALESFORCE_URL,
        refresh_token:  opts[:refresh_token],
        client_id:      opts[:client_id],
        client_secret:  opts[:client_secret],
        api_version:    '29.0'
      )
    end

    def campaign_by_name(name)
      @client.query(Queries.campaign_by_name(name))
    end

    def nested_campaigns(parent_id)
      query_string = Queries.child_campaigns(parent_id)
      @client.query(query_string)
    end

    def campaign_members(campaign_id, date: nil, &mapper)
      query_string = Queries.campaign_members(campaign_id)
      query = PaginatorDecorator.new(query_string, date)
      enumerator = block_given? ? Enumerator.new(mapper) : Enumerator.new
      Iterator.new(enumerator, query, @client).iterate
    end
  end
end
