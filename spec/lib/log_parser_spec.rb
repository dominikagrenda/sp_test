require_relative "../spec_helper"
require "log_parser"

RSpec.describe LogParser do
  let(:log) { "webserver_sample.log" }
  subject { described_class.new(log) }

  describe "#parse" do
    let(:expected_output) do
      {
        "/help_page/1" => ["126.318.035.038", "126.318.035.038", "722.247.931.582", "646.865.545.408"],
        "/home" => ["235.313.352.950", "235.313.352.950", "316.433.849.805"],
        "/contact" => ["184.123.665.067", "184.123.665.067"],
        "/about/2" => ["444.701.448.104"],
        "/about" => ["061.945.150.735"],
      }
    end

    it "parses the data correctly" do
      expect(subject.parse).to eq(expected_output)
    end
  end

  describe "#frequency" do
    before { subject.parse }

    let(:expected_output) do
      {
        "/help_page/1" => 4,
        "/home" => 3,
        "/contact" => 2,
        "/about/2" => 1,
        "/about" => 1,
      }
    end

    it "returns the proper output" do
      expect(subject.frequency).to eq(expected_output)
    end
  end

  describe "#frequency_unique" do
    before { subject.parse }

    let(:expected_output) do
      {
        "/help_page/1" => 3,
        "/home" => 2,
        "/contact" => 1,
        "/about/2" => 1,
        "/about" => 1,
      }
    end

    it 'returns the proper output' do
      expect(subject.frequency_unique).to eq(expected_output)
    end
  end
end