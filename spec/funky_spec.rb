# frozen_string_literal: true

RSpec.describe Funky do
  it "has a version number" do
    expect(Funky::VERSION).not_to be nil
  end

  describe ".config" do
    let(:bot) { Funky::Bot.new }

    it "sets an access token from config" do
      Funky.config do |config|
        config.access_token = "123"
      end

      expect(bot.access_token).to eq("123")
    end
  end
end
