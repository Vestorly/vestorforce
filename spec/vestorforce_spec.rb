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
    it 'returns campaign members' do
    end
  end
end
