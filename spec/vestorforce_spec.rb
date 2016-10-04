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
    it 'returns nested campaigns' do
      query_string = "SELECT Id, Email, FirstName, LastName FROM " \
        "CampaignMember where CampaignId='12345'"
      expect(restforce).to receive(:query).with(query_string)
      api = described_class.client({})
      api.campaign_members('12345')
    end
  end

  describe '#decorators' do
    it "decorates" do
      query_string = SalesforceCampaign::Queries.campaign_by_name('Vestorly')
      query = SalesforceCampaign::PaginatorDecorator.new(query_string)
      query.prepare_query
    end
  end
end
