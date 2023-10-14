RSpec.describe Funky::Bot do
  it "initializes with default values" do
    bot = Funky::Bot.new
    expect(bot.access_token).to eq(ENV["OPENAI_API_KEY"])
    expect(bot.history).to eq([])
    expect(bot.language_model).to eq("gpt-3.5-turbo")
    expect(bot.temperature).to eq(0.5)
    expect(bot.include_functions).to eq(true)
    expect(bot.params).to eq({})
  end
end
