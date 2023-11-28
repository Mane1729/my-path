import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import jsonData from './ProjectManagement.json';
import './../App.css';
import Skill3 from './Skill3';

import gql from 'graphql-tag';
import { useMutation } from '@apollo/react-hooks';

const CREATE_USER = gql`
  mutation AssessUserProjectManagemenSkill($userId: ID!, $answer: String!) {
    assessUserProjectManagementSkill(userId: $userId, answer: $answer) {
      success
      errors
    }
  }
`;

function Skill2() {
  const questions = Object.keys(jsonData);

  const [responses, setResponses] = useState({});
  const [AssessUserProjectManagemenSkill] = useMutation(CREATE_USER); 

  const handleResponseChange = (question, response) => {
    setResponses({ ...responses, [question]: response });
  };

  const mapResponsesToMutationFormat = () => {

    return responses;
  };

  const submitResponses = async () => {
    try {
      const mappedResponses = mapResponsesToMutationFormat();
      const answersString = JSON.stringify(mappedResponses);
  
      console.log('Collected Responses:', responses);
      console.log('Mapped Responses for Mutation:', answersString);
  
      if (!answersString) {
        throw new Error('Invalid value for answersString');
      }
  
      const response = await AssessUserProjectManagemenSkill({
        variables: {
          userId: '2', // replace with actual user ID
          answer: answersString, 
        },
      });

      // handle response, e.g., navigate to another page or show success message
      console.log('Mutation Response:', response);
    } catch (error) {
      // handle error, e.g., show error message
      console.error('Mutation Error:', error);
    }
  };
  
  

  return (
    <div>
      <header>
        <h1>Project management</h1>
      </header>
      <main>
        <section>
          <ul>
            {questions.map((question, index) => (
              <li key={index}>
                <br />
                <h3>{jsonData[question].question}</h3>
                <textarea
                  value={responses[question] || ''}
                  onChange={(e) => handleResponseChange(question, e.target.value)}
                />
              </li>
            ))}
          </ul>
        </section>
      </main>
      <section>
        <h2>Collected Responses:</h2>
        <pre>{JSON.stringify(responses, null, 2)}</pre>
      </section>
      <footer>
        {/* &copy; 2023 My Website */}
      </footer>
      <Link to="/skill3">
        <button onClick={submitResponses}>Next </button>
      </Link>
    </div>
  );
}

export default Skill2;