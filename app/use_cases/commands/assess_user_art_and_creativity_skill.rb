module Commands
  class AssessUserArtAndCreativitySkill
    extend Base

    def initialize(user_id:, idea_count:, answer:)
      @user_id = user_id
      @idea_count = idea_count
      @answer = answer
    end

    attr_reader :user_id, :idea_count, :answer

    def perform
      user = User.find_by(id: user_id)
      return error('User not found') if user.nil?

      if has_art_and_creativity_skill(idea_count, answer)
        art_and_creativity_skill = Skill.find_by(name: "Art and Creativity")
        return error('Art and Creativity skill not found') if art_and_creativity_skill.nil?

        users_skill = UsersSkill.create(user:, skill: art_and_creativity_skill)
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

    def has_art_and_creativity_skill(idea_count, answer)
      return false if idea_count < 4

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
      prompt = "Determine if the user's ideas for practical uses of a shoelace are generally feasible. If the majority of the ideas listed can realistically be created or enhanced using a shoelace, respond with 'yes.' Otherwise, answer 'no.' 
      For example these are valid ideas: bookmark, key ring, hair tie, bracelet or necklace, picture hanger, emergency belt, plant ties, luggage identifier, cat's toy, curtain tie-back, shoe organizer, craft material, zipper pull, glasses strap, makeshift clothesline, bottle carrier, jump rope, puzzle keeper, handbag accessory, camping gear tie.\n
      Evaluate the following ideas: 
      #{answer}\n
      Provide a single-word answer for the entire list: 'yes' or 'no'."

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
