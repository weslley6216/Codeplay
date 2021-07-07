require 'rails_helper'

context User do
  describe 'validation' do
    it { should validate_presence_of(:email) }
  end
end
