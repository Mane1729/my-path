require "ruby/openai"

class OpenaiTester < ApplicationService
  def call 
    api_key = ENV.fetch('OPENAI_ACCESS_KEY')

    client = OpenAI::Client.new(access_token: api_key)
    response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          messages: [{ role: "user", content: "Tell a joke"}],
          temperature: 0.7,
      })
  
    puts response.dig("choices", 0, "message", "content")
  end
end