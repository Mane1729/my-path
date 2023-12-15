import React from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import { useQuery } from '@apollo/react-hooks';
import gql from 'graphql-tag';


const GET_USER_INFO = gql`
  query user {
    user {
      emergingJob {
        name
        industry
        description
        image
      }
      lackingSkills {
        name
        icon
      }
    }
  }
`;

function SuccessPage() {
  const { loading, error, data } = useQuery(GET_USER_INFO);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error</p>;

  const emergingJob = data.user.emergingJob || {};
  let { name, industry, description, image } = emergingJob;

  const defaultImage = "https://drive.google.com/uc?export=view&id=10E4toF2kbitL19RPshgRllmwCqtPmibi";
  image = image || defaultImage;

  const hasSkillsToImprove = data.user.lackingSkills && data.user.lackingSkills.length > 0;

  return (
    <>
      <header className="page-header">
        <h1>My Path</h1>
      </header>
      <div className="success-page-container">
        <div className="emerging-job-section">
          {image && (
            <img
              className="specialist-image"
              src={process.env.PUBLIC_URL + image}
              alt={`${name}`}
            />
          )}
          <div className="job-description">
            <h1>{name || 'Your Future Job'}</h1>
            <p><strong>Industry:</strong> {industry || 'Not available'}</p>
            <p>{description || 'No description provided'}</p>
            {hasSkillsToImprove && (
              <div className="skills-section">
                <div className="skills-heading">
                  <span className="heading-line"></span>
                  <h3 class="skills-to-improve">Skills to Improve</h3>
                  <span className="heading-line"></span>
                </div>
                <div className="skills-list">
                  {data.user.lackingSkills.map((skill, index) => (
                    <div key={index} className="skill-item">
                      {image && (
                        <img
                          className="skill-icon"
                          src={process.env.PUBLIC_URL + skill.icon}
                          alt={skill.name}
                        />
                      )}
                      <span className="skill-name">{skill.name}</span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </>
  );
}

export default SuccessPage;
