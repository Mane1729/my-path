class CreateEnums < ActiveRecord::Migration[7.0]
  def up
    create_enum :yes_no, %w[yes no]
    create_enum :quality, %w[excellent poor medium]
    create_enum :interested_subject, ['cloud computing', 'networks', 'hacking', 'Computer Architecture',
      'programming', 'parallel computing', 'IOT', 'data engineering',
      'Software Engineering', 'Management']
    create_enum :book_genre, ['Prayer books', 'Childrens', 'Travel', 'Romance', 'Cookbooks',
      'Self help', 'Drama', 'Math', 'Religion-Spirituality', 'Anthology',
      'Trilogy', 'Autobiographies', 'Mystery', 'Diaries', 'Journals',
      'History', 'Art', 'Dictionaries', 'Horror', 'Encyclopedias',
      'Action and Adventure', 'Fantasy', 'Comics', 'Science fiction',
      'Series', 'Guide', 'Biographies', 'Health', 'Satire', 'Science',
      'Poetry']
    create_enum :behaviour, %w[stubborn gentle]
    create_enum :management_technical, %w[Management Technical]
    create_enum :salary_work, %w[salary work]
    create_enum :worker_type, ['hard worker', 'smart worker']
    create_enum :career, ['Database Developer', 'Portal Administrator',
      'Systems Security Administrator', 'Business Systems Analyst',
      'Software Systems Engineer', 'Business Intelligence Analyst',
      'CRM Technical Developer', 'Mobile Applications Developer',
      'UX Designer', 'Quality Assurance Associate', 'Web Developer',
      'Information Security Analyst', 'CRM Business Analyst',
      'Technical Support', 'Project Manager',
      'Information Technology Manager', 'Programmer Analyst',
      'Design & UX', 'Solutions Architect', 'Systems Analyst',
      'Network Security Administrator', 'Data Architect',
      'Software Developer', 'E-Commerce Analyst',
      'Technical Services/Help Desk/Tech Support',
      'Information Technology Auditor', 'Database Manager',
      'Applications Developer', 'Database Administrator',
      'Network Engineer', 'Software Engineer', 'Technical Engineer',
      'Network Security Engineer',
      'Software Quality Assurance (QA) / Testing']
  end

  def down
    execute <<-SQL.squish
      DROP TYPE yes_no;
      DROP TYPE quality;
      DROP TYPE interested_subject;
      DROP TYPE book_genre;
      DROP TYPE behaviour;
      DROP TYPE management_technical;
      DROP TYPE salary_work;
      DROP TYPE worker_type;
      DROP TYPE career;
    SQL
  end
end
