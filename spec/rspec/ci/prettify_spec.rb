# frozen_string_literal: true

RSpec.describe RSpec::Ci::Prettify do
  it "has a version number" do
    expect(RSpec::Ci::Prettify::VERSION).not_to be nil
  end

  it "failing example" do
    expect(RSpec::Ci::Prettify::VERSION).to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
