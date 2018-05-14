require 'spec_helper'
require 'restforce'
require 'pry'

describe Vestorforce do
  let(:members_response) do
    Struct.new('Member', :Id, :Email)
    4.times.map do |i|
      Struct::Member.new(i, "email#{i}@example.com")
    end
  end
  let(:restforce) { instance_double('Restforce::Client') }
  let(:vestorforce_client) { described_class.client({}) }

  before do
    allow(Restforce).to receive(:new).and_return(restforce)
  end

  describe '#client' do
    it 'returns an Api class object' do
      expect(vestorforce_client.class.name).to eq 'Vestorforce::Api'
    end
  end

  describe '#campaign_by_name' do
    let(:campaign_name) { 'Vestorly' }
    let(:query_string) do
      'SELECT Id, Name, NumberOfContacts, NumberOfLeads ' \
        "FROM Campaign where name='#{campaign_name}'"
    end

    it 'returns campaigns' do
      expect(restforce).to receive(:query).with(query_string)
      vestorforce_client.campaign_by_name(campaign_name)
    end
  end

  describe '#nested_campaigns' do
    let(:campaign_id) { '12345' }
    let(:query_string) do 
      'SELECT Id, Name, NumberOfContacts, NumberOfLeads From ' \
        "Campaign where ParentId='#{campaign_id}'"
    end

    it 'returns nested campaigns' do
      expect(restforce).to receive(:query).with(query_string)
      vestorforce_client.nested_campaigns(campaign_id)
    end
  end

  describe '#campaign_members' do
    let(:query_string) { 'Test Query' }
    let(:campaign_id) { '123' }

    before do
      allow(Vestorforce::Queries)
        .to receive(:campaign_members)
        .with(campaign_id)
        .and_return(query_string)
    end

    it 'returns a batch_array for campaign members' do
      expect(Vestorforce::BatchArray)
        .to receive(:new)
        .with(
          query: query_string,
          client: restforce,
          date: nil,
          offset: 0,
          batch_size: 100
        )
      vestorforce_client.campaign_members(campaign_id)
    end
  end
end
