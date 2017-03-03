require_relative '../../main.rb'

RSpec.describe(User, ".all") do
  it "creates a hash of all user data" do

    expect(User.all).to be_a(hash)
  end
end