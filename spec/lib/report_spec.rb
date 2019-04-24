require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.describe ReportSender do
  describe '#send' do
    xit 'works' do
      described_class.new.send('foo', 'bar')
    end
  end
end
