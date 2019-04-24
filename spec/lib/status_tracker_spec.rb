require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.describe Handler do
  describe '#call' do
    let(:status_requester) { double StatusRequest }
    let(:report) { double Report }

    it 'launch StatusRequest' do
      data = {
        foo: '200',
        bar: '200',
      }

      allow(status_requester).to receive(:call).and_return(data)

      described_class.new(
        request: status_requester,
        report: report
      ).call

      expect(status_requester).to have_received(:call).once
    end

    context 'previous status is different than new' do
      it 'launch ReportSeder' do
        data = {
          foo: '200',
          bar: '200',
        }
        previous_data = {
          foo: '500',
          bar: '200',
        }

        allow(status_requester).to receive(:call).and_return(data)
        allow(report).to receive(:send)

        described_class.new(
          previous_data: previous_data,
          request: status_requester,
          report: report,
        ).call

        expect(report).to have_received(:send).with(:foo, '200', '500').once
        expect(report).not_to have_received(:send).with(:bar, '200', '200')
      end
    end

    context 'previous data is nil' do
      it "doesn't launch ReportSender" do
        data = {
          foo: '200',
          bar: '200',
        }

        allow(status_requester).to receive(:call).and_return(data)
        allow(report).to receive(:send)

        described_class.new(
          request: status_requester,
          report: report
        ).call

        expect(report).not_to have_received(:send)
      end
    end

    context 'previous status is equal to new' do
      it "doesn't launch ReportSender" do
        data = {
          foo: '200',
          bar: '200',
        }
        previous_data = {
          foo: '200',
          bar: '200',
        }

        allow(status_requester).to receive(:call).and_return(data)
        allow(report).to receive(:send)

        described_class.new(
          previous_data: previous_data,
          request: status_requester,
          report: report
        ).call

        expect(report).not_to have_received(:send)
      end
    end
  end
end
