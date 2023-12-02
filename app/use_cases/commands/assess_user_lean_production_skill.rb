module Commands
  class AssessUserLeanProductionSkill
    extend Base

    def initialize(user_id:, answer:)
      @user_id = user_id
      @answer = answer
    end

    attr_reader :user_id, :answer

    def perform
      user = User.find_by(id: user_id)
      return error('User not found') if user.nil?

      if has_lean_production_skill(answer)
        lean_production_skill = Skill.find_by(name: "Lean production")
        return error('Lean production skill not found') if lean_production_skill.nil?

        users_skill = UsersSkill.create(user:, skill: lean_production_skill)
        return error(users_skill.errors.full_messages) unless users_skill.persisted?
      end
      
      success
    rescue => e
      return error(e.message)
    end

    private

    def success
      { success: true, errors: [] }
    end

    def error(message)
      { success: false, errors: [message].flatten }
    end

    def has_lean_production_skill(answer)
      has_skill = Settings.openai_api_enabled ? call_openai_api(answer) : 'no'

      if has_skill == 'yes'
        true
      elsif has_skill == 'no'
        false
      else
        raise 'Error with OpenAI API'
      end
    end

    def call_openai_api(answer)
      prompt = "Based on the following response to a scenario, assess if the user demonstrates lean production skills.\n
      Scenario Question:
      Imagine you're working at a local coffee shop. You notice that during peak hours, the queue often backs up and customers are waiting for a long time. You've identified that the time-consuming part is the process of making the coffee itself, which includes: taking the order, collecting payment, passing the order to the barista, preparing the coffee, serving the coffee to the customer, and then cleaning up for the next order. How would you improve this process and reduce the waiting time for customers?\n      
      User's Answer:
      #{answer}\n
      Respond with one word: 'yes' or 'no'"

      api_key = ENV.fetch('OPENAI_ACCESS_KEY')

      # TODO: Move this to a base class to avoid duplication in other classes (for example Commands::AssessUserProjectManagementSkill)
      client = OpenAI::Client.new(access_token: api_key)
      response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: [{ role: "user", content: prompt}],
            temperature: 0.7,
        })

      response.dig("choices", 0, "message", "content").downcase
    end
  end
end
