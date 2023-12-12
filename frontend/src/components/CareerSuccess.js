import React from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import { useQuery } from '@apollo/react-hooks';
import gql from 'graphql-tag';
import emergingJobsData from 'emerging_jobs.json';


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

  return (
    <div class="notification">
      <p>Your operation was successful!</p>
      <div class="job-details">
      {emergingJobsData.map((job, index) => (
        job.image && (
          <img
            key={index}
            class="job-image"
            src={process.env.PUBLIC_URL + job.image}
          />
        )
      ))}
        <p><strong>Emerging Job:</strong> {name}</p>
        <p><strong>Industry:</strong> {industry}</p>
        <p><strong>Description:</strong> {description}</p>
        <h3>Lacking Skills:</h3>
        <ul class="skills-list">
          {data.user.lackingSkills.map((skill, index) => (
            <li key={index} class="skill-item">{skill.name}</li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default SuccessPage;