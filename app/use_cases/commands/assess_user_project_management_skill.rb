module Commands
  class AssessUserProjectManagementSkill
    extend Base

    def initialize(user_id:, answer:)
      @user_id = user_id
      @answer = answer
    end

    attr_reader :user_id, :answer

    def perform
      user = User.find_by(id: user_id)
      return error('User not found') if user.nil?

      if has_project_management_skill(answer)
        project_management_skill = Skill.find_by(name: "Project management")
        return error('Project management skill not found') if project_management_skill.nil?

        users_skill = UsersSkill.create(user:, skill: project_management_skill)
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

    def has_project_management_skill(answer)
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
      prompt = "Based on the following answer, does the user have project management skills?\n
      Question:
      Describe a project or an initiative (it could be a school project, an event, a personal project, etc.) where you had to take charge or play a significant role. How did you plan, organize, and execute this project? What challenges did you face and how did you overcome them?\n
      Answer:
      #{answer}\n
      Answer in one word: 'yes' or 'no'"

      api_key = ENV.fetch('OPENAI_ACCESS_KEY')

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
