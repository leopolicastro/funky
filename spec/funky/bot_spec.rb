RSpec.describe Funky::Bot do
  let(:bot) { described_class.new }

  describe "#initialize" do
    describe "with default values" do
      it "sets an access token" do
        expect(bot.access_token).to eq(ENV["OPENAI_API_KEY"])
      end

      it "sets a language model" do
        expect(bot.language_model).to eq("gpt-3.5-turbo")
      end

      it "sets a temperature" do
        expect(bot.temperature).to eq(0.5)
      end

      it "sets include functions" do
        expect(bot.include_functions).to eq(true)
      end

      it "sets params" do
        expect(bot.params).to eq({})
      end

      it "sets the response as empty hash" do
        expect(bot.response).to eq({})
      end

      it "sets a client" do
        expect(bot.client).to be_a(Funky::Client)
      end

      it "sets a history" do
        expect(bot.history).to be_a(Funky::History)
      end
    end

    describe "with custom values" do
      let(:bot) do
        described_class.new(
          access_token: "123",
          language_model: "gpt-3",
          temperature: 0.7,
          include_functions: false,
          params: {foo: "bar"}
        )
      end

      it "sets an access token" do
        expect(bot.access_token).to eq("123")
      end

      it "sets a language model" do
        expect(bot.language_model).to eq("gpt-3")
      end

      it "sets a temperature" do
        expect(bot.temperature).to eq(0.7)
      end

      it "sets include functions" do
        expect(bot.include_functions).to eq(false)
      end

      it "sets params" do
        expect(bot.params).to eq({foo: "bar"})
      end
    end
  end
  describe "#ask" do
    let(:bot) { described_class.new }
    context "with a question that does not require a function" do
      let(:question) { "What is the meaning of life?" }

      it "adds messages to the history" do
        VCR.use_cassette("ask") do
          expect { bot.ask(question) }.to change { bot.history.messages.count }.by(2)
        end
      end

      it "sets and returns the last response" do
        VCR.use_cassette("ask") do
          expect(bot.ask(question)).to eq(bot.last_response)
          expect(bot.ask(question)).to eq(bot.history.messages.last[:content])
        end
      end
    end

    context "with a question that requires a function" do
      let(:question) { "What is the weather like in New York?" }

      it "calls the function handler" do
        VCR.use_cassette("ask_with_function") do
          expect_any_instance_of(Funky::Functions::Handler).to receive(:handle)
          bot.ask(question)
        end
      end

      it "adds the function to the history" do
        VCR.use_cassette("ask_with_function") do
          expect { bot.ask(question) }.to change { bot.history.messages.count }.by(3)
          expect(bot.history.messages.count { |m|
            m[:role] == "function"
          }).to eq(1)
        end
      end
    end
  end
end
