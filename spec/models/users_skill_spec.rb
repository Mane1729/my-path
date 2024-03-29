require 'rails_helper'

RSpec.describe UsersSkill, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:skill) }
  end
end
