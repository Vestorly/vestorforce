require 'spec_helper'
require 'restforce'
require 'pry'

describe Vestorforce do
  let(:restforce) { double('RestforceClient') }
  before do
    expect(Restforce).to receive(:new).and_return(restforce)
  end

  describe '#client' do
    it 'returns an Api class object' do
      expect(described_class.client({}).class.name).to eq 'Vestorforce::Api'
    end
  end

  describe '#parent_campaign' do
    it 'returns campaigns' do
      expect(restforce)
        .to receive(:query)
        .with("SELECT Id FROM Campaign where name='Vestorly'")
      client = described_class.client({})
      client.campaign_by_name('Vestorly')
    end
  end

  describe '#nested_campaigns' do
    it 'returns nested campaigns' do
      query_string = "SELECT Id, Name, NumberOfContacts, NumberOfLeads From " \
        "Campaign where ParentId='12345'"
      expect(restforce).to receive(:query).with(query_string)
      api = described_class.client({})
      api.nested_campaigns('12345')
    end
  end

  describe '#campaign_members' do
    it 'does the right query call' do
      query_string = "SELECT Id, Email, FirstName, LastName FROM CampaignMember " \
        "where CampaignId='12345' where (email <>'' or email <> NULL) " \
        "ORDER BY Id LIMIT 1000"
      expect(restforce).to receive(:query).with(query_string)
      api = described_class.client({})
      api.campaign_members('12345') do |item|
        item
      end
    end

    #new_s = Struct.new("Item", :Id, :Email)
    it 'enumerates over the results using the default mapper' do
      query_string = "SELECT Id, Email, FirstName, LastName FROM CampaignMember " \
        "where CampaignId='12345' where (email <>'' or email <> NULL) " \
        "ORDER BY Id LIMIT 1000"
      result_items = ['1', '2', '3', '4']
      expect(restforce).to receive(:query).with(query_string).and_return(result_items)
      api = described_class.client({})
      members = api.campaign_members('12345')
      binding.pry
      puts
    end

    it 'enumerates over the results using a custom mapper' do
      query_string = "SELECT Id, Email, FirstName, LastName FROM CampaignMember " \
        "where CampaignId='12345' where (email <>'' or email <> NULL) " \
        "ORDER BY Id LIMIT 1000"
      result_items = ['1', '2', '3', '4']
      expect(restforce).to receive(:query).with(query_string).and_return(result_items)
      api = described_class.client({})
      count = 0
      api.campaign_members('12345') do |item|
        count += 1
        expect(item.to_i).to eq count
        item
      end
      expect(count).to eq 4
    end
  end
end
