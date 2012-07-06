require 'spec_helper'

describe Candidate do
  context 'associations' do
    it { should have_many(:proposals) }
  end

  context 'validations ' do
    it { should validate_presence_of :name }

    it { should ensure_length_of(:about).is_at_most(500) }
    it { should ensure_length_of(:phone).is_equal_to(13) }
       
    it { should validate_format_of(:site).not_with("invalid_url") }
    it { should validate_format_of(:blog).not_with("invalid_url") }
    it { should validate_format_of(:facebook).not_with("invalid_url") }
    it { should validate_format_of(:twitter).not_with("invalid_url") }
    
    it { should allow_value(nil).for(:press_agent) }  
    it { should allow_value(true).for(:press_agent) }
    it { should allow_value(false).for(:press_agent) }
    it { should ensure_length_of(:about).is_at_most(500) }

    it { should ensure_length_of(:phone).is_equal_to(13) }

    it { should validate_presence_of :email }
    it { should validate_format_of(:email).with("valid@email.com") }
    it { should validate_format_of(:email).not_with("invalid.com") }
  end

  it 'should generate a unique slug for candidate' do
    Digest::SHA1.should_receive(:hexdigest).with('Test').and_return('obfuscated')
    candidate = Candidate.create!(:name => 'Test', :email => 'test@test.com')
    candidate.obfuscated_slug.should == 'obfuscated'
  end
end
