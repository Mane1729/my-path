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
      }
    }
  }
`;

function SuccessPage() {
  const { loading, error, data } = useQuery(GET_USER_INFO);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error</p>;

  const emergingJob = data.user.emergingJob || {};
  const { name, industry, description, image } = emergingJob;

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
                  <h3>Skills to Improve</h3>
                  <span className="heading-line"></span>
                </div>
                <div className="skills-list">
                  {data.user.lackingSkills.slice(0, 3).map((skill, index) => (
                    <div key={index} className="skill-item">
                      <img src={process.env.PUBLIC_URL + 'https://drive.google.com/uc?export=view&id=1IXUU-bCJZHzhHMEDIHDKBrkyvdMFERK7'} alt={skill.name} className="skill-icon" />
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
