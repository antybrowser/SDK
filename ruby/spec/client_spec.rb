# frozen_string_literal: true

require "antybrowser"

RSpec.describe Antybrowser::Client do
  it "has a version number" do
    expect(Antybrowser::VERSION).not_to be_nil
  end

  it "creates a client with default port" do
    client = Antybrowser::Client.new("test_key")
    expect(client.base_url).to eq("http://127.0.0.1:5173")
    expect(client.api_key).to eq("test_key")
  end

  it "creates a client with custom port" do
    client = Antybrowser::Client.new("test_key", port: 5174)
    expect(client.base_url).to eq("http://127.0.0.1:5174")
  end

  it "creates a client with custom base URL" do
    client = Antybrowser::Client.new("test_key", base_url: "http://10.0.0.5:8080")
    expect(client.base_url).to eq("http://10.0.0.5:8080")
  end
end
