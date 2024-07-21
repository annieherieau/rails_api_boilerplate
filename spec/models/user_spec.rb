require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do 
    @user = FactoryBot.create(:user)
  end

  it "has a valid factory" do
    # teste toujours tes factories pour voir si elles sont valides
    expect(build(:user)).to be_valid
  end
  # TODO validates :email, presence: true, uniqueness: true
end
