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

  return (
    <div>
      <p>Your operation was successful!</p>
      <div>
        <p><strong>Emerging Job:</strong> {data.user.emergingJob.name}</p>
        <p><strong>Industry:</strong> {data.user.emergingJob.industry}</p>
        <p><strong>Description:</strong> {data.user.emergingJob.description}</p>
        <h3>Lacking Skills</h3>
        {data.user.emergingJob.image && (<img
                      src={process.env.PUBLIC_URL + data.user.emergingJob.image}
                      style={{ maxWidth: '100%' }} alt="Specialist_Image"
                    />
                  )}
        <ul>
          {data.user.lackingSkills.map((skill, index) => (
            <li key={index}>{skill.name}</li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default SuccessPage;
