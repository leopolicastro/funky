# frozen_string_literal: true

module Funky
  module Functions
    class BaseFunction
      attr_reader :bot, :params
      def initialize(bot, params = {})
        @bot = bot
        @params = params
      end

      def parsed_response
        JSON.parse(
          bot.response.dig("choices", 0, "message", "function_call", "arguments")
        )
      end
    end
  end
end
