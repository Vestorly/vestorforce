require 'spec_helper'
require 'restforce'
require 'pry'

describe Vestorforce::Api do
  let(:auth_hash) do
    {
      oauth_token:      ENV['oath_token'],
      instance_url:     ENV['instance_url'],
      refresh_token:    ENV['refresh_token'],
      client_id:        ENV['client_id'],
      client_secret:    ENV['client_secret']
    }
  end
  let(:instance) { described_class.new(auth_hash) }
  let(:parent_campaign_id) { '701f4000000UZyIAAW' }

  it 'connects correctly to the restforce api' do
    instance
    client = instance.instance_variable_get(:@client)
    client_options = client.options

    expect(client_options)
      .to include(auth_hash)
      .and include(api_version: '29.0')
  end

  describe '#campaign_by_name' do
    subject(:campaign_by_name) { instance.campaign_by_name('Vestorly') }

    it 'returns a campaign with the correct format' do
      campaign = campaign_by_name.first

      expect(campaign).to respond_to(:Id, :Name)
      expect(campaign.Id).to eq(parent_campaign_id)
    end
  end

  describe '#nested_campaigns' do
    subject(:nested_campaigns) { instance.nested_campaigns(parent_campaign_id) }

    it 'returns all nested campaigns' do
      campaign = nested_campaigns.first

      expect(campaign.Name).to eq('Nested')
      expect(campaign).to respond_to(:Id)
    end
  end

  describe '#campaign_members' do
    it 'iterates over campaign members from one campaign' do
      expect { |b| instance.campaign_members(parent_campaign_id, &b) }
        .to yield_control
        .exactly(2)
        .times
    end
  end
end
