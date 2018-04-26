require 'spec_helper'
require 'restforce'
require 'pry'

describe Vestorforce do
  let(:restforce) { double('RestforceClient') }
  let(:members_response) do
    Struct.new('Member', :Id, :Email)
    4.times.map do |i|
      Struct::Member.new(i, "email#{i}@example.com")
    end
  end

  before do
    expect(Restforce).to receive(:new).and_return(restforce)
  end

  describe '#client' do
    it 'returns an Api class object' do
      expect(described_class.client({}).class.name).to eq 'Vestorforce::Api'
    end
  end

  describe '#campaign_by_name' do
    it 'returns campaigns' do
      expect(restforce)
        .to receive(:query)
        .with("SELECT Id, Name, NumberOfContacts, NumberOfLeads FROM Campaign where name='Vestorly'")
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
    let(:select_query) do
      "SELECT Id, ContactId, LeadId, Contact.Email, Lead.Email, Contact.FirstName, " \
        "Lead.FirstName, Contact.LastName, Lead.LastName " \
        "FROM CampaignMember "
    end
    it 'does the right query call' do
      query_string = "#{select_query}" \
        "where CampaignId='12345' " \
        "ORDER BY Id LIMIT 100"
      expect(restforce).to receive(:query).with(query_string)
      api = described_class.client({})
      api.campaign_members('12345')
    end

    it 'does the right query call with a certain date' do
      query_string = "#{select_query}" \
        "where CampaignId='12345' " \
        "and (CreatedDate > 1700-01-01T00:00:00Z) " \
        "ORDER BY Id LIMIT 100"
      expect(restforce).to receive(:query).with(query_string)
      api = described_class.client({})
      api.campaign_members('12345', date: '1700-01-01T00:00:00Z')
    end

    it 'enumerates over the results using a custom mapper' do
      query_string = "#{select_query}" \
        "where CampaignId='12345' " \
        "ORDER BY Id LIMIT 100"
      query_string2 = "#{select_query}" \
        "where CampaignId='12345' " \
        "and (Id > '3') " \
        "ORDER BY Id LIMIT 100"
      allow(restforce).to receive(:query).with(query_string).and_return(members_response)
      allow(restforce).to receive(:query).with(query_string2).and_return([])
      api = described_class.client({})
      count = 0
      api.campaign_members('12345') do |item|
        expect(item.Id).to eq count
        count += 1
      end
      expect(count).to eq 4
    end
  end
end
