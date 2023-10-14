# frozen_string_literal: true

require_relative "funky/version"

module Funky
  class Error < StandardError; end

  class << self
    attr_accessor :functions_path, :access_token

    def config
      yield self if block_given?
    end
  end

  class Bot
    attr_accessor :access_token, :history, :language_model, :temperature, :include_functions, :params, :client, :open_ai_client, :response

    def initialize(
      access_token: Funky.access_token,
      language_model: "gpt-3.5-turbo",
      temperature: 0.5,
      include_functions: true,
      initial_prompt: "You are a helpful assistant.",
      params: {}
    )
      @access_token = access_token
      @client = Funky::Client.new(self)
      @history = Funky::History.new
      @language_model = language_model
      @temperature = temperature
      @include_functions = include_functions
      @params = params
      @response = {}
      history.chronicle("system", initial_prompt)
    end

    def ask(question)
      history.chronicle("user", question)
      client.call

      Funky::Functions::Handler.new(self).handle if function_present?

      history.chronicle("assistant", last_response)
      last_response
    end

    def last_response
      response.dig("choices", 0, "message", "content")
    end

    private

    def function_present?
      !response.dig("choices", 0, "message", "function_call").nil?
    end
  end
end
