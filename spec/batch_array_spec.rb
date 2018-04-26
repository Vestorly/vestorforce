require 'spec_helper'
require 'restforce'
require 'pry'

describe Vestorforce::BatchArray do
  let(:query) { Vestorforce::Queries.campaign_members('123') }
  let(:client) { instance_double(Restforce::Client) }

  let(:members_response) do
    Struct.new('Member', :Id, :Email)
    Array.new(4) do |i|
      Struct::Member.new(i, "email#{i}@example.com")
    end
  end

  describe '#batch_each' do
    context 'with all of the campaign members contained in the initial batch' do
      let(:instance) { described_class.new(query: query, client: client) }

      it 'iterates over all items in the batch' do
        expect(client)
          .to receive(:query)
          .with(/OFFSET 0/)
          .and_return(members_response)
        expect(client)
          .to receive(:query)
          .with(/OFFSET 50/)
          .and_return([])

        expect { |b| instance.batch_each(&b) }
          .to yield_control
          .exactly(4)
          .times
      end
    end

    context 'when users are processed in multiple batches' do
      let(:instance) do
        described_class.new(
          query: query,
          client: client,
          date: 2.years.ago,
          offset: 1,
          batch_size: 2
        )
      end

      let(:members_response1) { [members_response[1], members_response[2]] }
      let(:members_response2) { [members_response[3]] }

      it 'calls block on all items in the batch' do
        expect(client)
          .to receive(:query)
          .with(/OFFSET 1/)
          .and_return(members_response1)
        expect(client)
          .to receive(:query)
          .with(/OFFSET 3/)
          .and_return(members_response2)
          expect(client)
          .to receive(:query)
          .with(/OFFSET 5/)
          .and_return([])

        expect { |b| instance.batch_each(&b) }
          .to yield_control
          .exactly(3)
          .times
      end
    end

    context 'when query is empty' do
      let(:instance) do
        described_class.new(
          query: query,
          client: client,
          date: 2.years.ago,
          offset: 5
        )
      end

      it 'calls block on no items' do
        expect(client)
          .to receive(:query)
          .with(/OFFSET 5/)
          .and_return([])

        expect { |b| instance.batch_each(&b) }
          .to yield_control
          .exactly(0)
          .times
      end
    end
  end
end
