require "station"

describe Station do
  it "Should have a zone" do
    expect(subject.zone).to be_between(1, 10)
  end
end