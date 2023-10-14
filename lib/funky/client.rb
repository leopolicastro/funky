# frozen_string_literal: true

module Funky
  class Client
    attr_accessor :bot

    def initialize(bot)
      @bot = bot
    end

    def call
      bot.response = client.chat(
        parameters: chat_params
      )
    rescue => e
      Rails.logger.error(e.message)
      {error: e.message}
    end

    def chat_params
      params = {
        model: bot.language_model,
        messages: bot.history.messages,
        temperature: bot.temperature
      }
      params.merge!(function_params) if bot.include_functions
      params
    end

    def function_params
      {functions: Funky::Functions::List.call}
    end

    def client
      OpenAI::Client.new(access_token: bot.access_token)
    end
  end
end
