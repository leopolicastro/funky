require_relative "lib/funky"
require "dotenv/load"
require "byebug"

Funky.config do |config|
  config.functions_path = "/Users/leopolicastro/repos/funky/lib/funky/functions/"
  config.access_token = ENV["OPENAI_API_KEY"]
end

bot = Funky::Bot.new
bot.ask("What is the weather in Miami, FL?")
