module Commands
  class DetermineBestFitJob
    extend Base

    def initialize(user_id:, industries:)
      @user_id = user_id
      @industries = industries
    end

    attr_reader :user_id, :industries

    def perform
      user = User.find_by(id: user_id)
      return error('User not found') if user.nil?

      result = find_job(user:)
      link_job_to_user(user:, job: result[:emerging_job]) if result[:success]
      result
    end

    private

    def success(job, lacking_skills)
      { emerging_job: job, lacking_skills: lacking_skills, success: true, errors: [] }
    end


    def error(message)
      { success: false, errors: [message].flatten }
    end

    def find_job(user:)
      best_job = nil
      lacking_skills = []
      best_composite_score = -11

      jobs = industries.empty? ? EmergingJob.all : EmergingJob.where(industry: industries)

      jobs.each do |job|
        match_score = (job.skills & user.skills).count
        lacking_skills_count = (job.skills - user.skills).count
        composite_score = calculate_composite_score(match_score:, lacking_skills_count:)

        if composite_score > best_composite_score
          best_job = job
          best_composite_score = composite_score
          lacking_skills = job.skills - user.skills
        end
      end

      return error("Data is not enough for finding a suitable job") if best_job.nil? || lacking_skills.size > 3

      success(best_job, lacking_skills)
    end

    def calculate_composite_score(match_score:, lacking_skills_count:)
      match_score_weight = 1
      lacking_skills_weight = 1

      match_score * match_score_weight - lacking_skills_count * lacking_skills_weight
    end

    def link_job_to_user(user:, job:)
      user.emerging_job = job
      user.save
    end
  end
end
