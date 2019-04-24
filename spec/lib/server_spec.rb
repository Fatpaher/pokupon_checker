require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.describe Server do
  describe '.run' do
    it 'works' do
      StatusRequest::URLS.map do |url|
        stub_request(
          :get,
          url,
        ).to_return(status: 200)
      end

      allow(described_class).to receive(:loop) do |&block|
        expect { block.call }.not_to raise_error
      end

      described_class.run

      expect(described_class).to have_received(:loop)
    end

    context 'server status changed' do
      it 'send report only when status of server changed' do
        StatusRequest::URLS.map do |url|
          stub_request(
            :get,
            url,
          ).to_return({status: 200}, { status: 500 })
        end
        time = Time.now

        allow(described_class).to receive(:loop) do |&block|
          Timecop.travel(time)
          expect { block.call }.not_to change{ Mail::TestMailer.deliveries.length }

          Timecop.travel(time + 61)
          expect { block.call }.to change{ Mail::TestMailer.deliveries.length }.by(2)

          Timecop.travel(time + 121)
          expect { block.call }.not_to change{ Mail::TestMailer.deliveries.length }
        end

        described_class.run

        expect(described_class).to have_received(:loop)
      end
    end
  end
end
