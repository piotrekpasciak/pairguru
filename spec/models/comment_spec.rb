require "rails_helper"

describe Comment do
  it "has valid factory" do
    expect(build(:comment)).to be_valid
  end
end
