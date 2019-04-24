require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.describe Report do
  describe '#send' do
    before do
      Mail::TestMailer.deliveries.clear

      described_class.new.send('https://google.com', '200', '500')
    end

    it { is_expected.to have_sent_email }
    it { is_expected.to have_sent_email.from('email@example.com') }
    it { is_expected.to have_sent_email.to('alert@pokupon.ua') }
    it { is_expected.to have_sent_email.with_subject('Pokupon_checker. Status changed') }
    it { is_expected.to have_sent_email.with_body('https://google.com changed status from 500 to 200') }
  end
end
