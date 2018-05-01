require 'spec_helper'
require 'restforce'
require 'pry'

# This is a temporary test. Very hacky way 
# to check when the members response is changed.

describe Vestorforce::Queries do
  let(:auth_hash) do
    {
      oauth_token:     ENV['oath_token'],
      instance_url:    ENV['instance_url'],
      refresh_token:   ENV['refresh_token'],
      client_id:       ENV['client_id'],
      client_secret:   ENV['client_secret']
    }
  end
  let(:api) { Vestorforce::Api.new(auth_hash) }
  let(:client) { api.instance_variable_get(:@client) }
  let(:parent_campaign_id) { '701f4000000UZyIAAW' }
  let(:query_string) { Vestorforce::Queries.campaign_members(parent_campaign_id) }

  describe 'campaign members query' do
    it 'returns members in the correct format' do
      members = client.query(query_string)
      member = members.first

      expect(member).to respond_to(:Id, :Lead, :Contact, :ContactId, :LeadId)
      expect(member.Contact).to respond_to(:FirstName, :LastName, :Email)
      expect(member.Lead).to eq(nil)
      expect(member.LeadId).to eq(nil)
    end
  end
end
