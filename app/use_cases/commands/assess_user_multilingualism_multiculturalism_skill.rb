module Commands
  class AssessUserMultilingualismMulticulturalismSkill
    extend Base

    def initialize(user_id:, multilingualism_correct_count:, multiculturalism_answers:)
      @user_id = user_id
      @multilingualism_correct_count = multilingualism_correct_count
      @multiculturalism_answers = multiculturalism_answers
    end

    attr_reader :user_id, :multilingualism_correct_count, :multiculturalism_answers

    def perform
      user = User.find_by(id: user_id)
      return error('User not found') if user.nil?

      if has_multilingualism_multiculturalism_skill(multilingualism_correct_count, multiculturalism_answers)
        multilingualism_multiculturalism_skill = Skill.find_by(name: "Multilingualism / Multiculturalism")
        return error('Multilingualism / Multiculturalism skill not found') if multilingualism_multiculturalism_skill.nil?

        users_skill = UsersSkill.create(user:, skill: multilingualism_multiculturalism_skill)
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

    def has_multilingualism_multiculturalism_skill(multilingualism_correct_count, multiculturalism_answers)
      has_multilingualism_skill(multilingualism_correct_count) && has_multiculturalism_skill(multiculturalism_answers)
    end

    def has_multilingualism_skill(multilingualism_correct_count)
      multilingualism_correct_count > 7
    end

    def has_multiculturalism_skill(multiculturalism_answers)
      correct_answers = {
        sushi: 'c', 
        paella: 'a',
        colosseum: 'b',
        sydney_opera_house: 'c',
        kilt: 'a',
        hanbok: 'a'
      }

      correct_count = multiculturalism_answers.to_h.count { |question, answer| correct_answers[question] == answer }
      correct_count > 4
    end
  end
end
