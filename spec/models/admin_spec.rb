require 'rails_helper'

context Admin do
  describe 'validation' do
    it { should validate_presence_of(:email) }
  end
end
