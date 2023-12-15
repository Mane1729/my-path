import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import jsonData from './questionData/LeanProductionQuestions.json';
import './../App.css';

import gql from 'graphql-tag';
import { useMutation } from '@apollo/react-hooks';
import LeanProduction from '../Icons/LeanProduction.png';

const ASSESS_SKILL = gql`
  mutation AssessUserLeanProductionSkill($answer: String!) {
    assessUserLeanProductionSkill(answer: $answer) {
      success
      errors
    }
  }
`;

function Skill4() {
  const questions = Object.keys(jsonData);
  const [allQuestionsAnswered, setAllQuestionsAnswered] = useState(false);
  const [responses, setResponses] = useState({});
  const [AssessUserLeanProductionSkill] = useMutation(ASSESS_SKILL); 

  const handleResponseChange = (question, response) => {
    setResponses({ ...responses, [question]: response });
  };

  useEffect(() => {
    checkAllQuestionsAnswered();
  }, [responses]);

  const checkAllQuestionsAnswered = () => {
    const answered = questions.every((question) => responses[question] !== undefined && responses[question].trim() !== '');
    setAllQuestionsAnswered(answered);
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
  
      const response = await AssessUserLeanProductionSkill({
        variables: {
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
    <div class="skill">
    <header class="header">
    <div>
      <img className="icon" src={LeanProduction}/>
      </div>
      <div class="headerRight">
      <h1>Lean production</h1>
      </div>
      </header>
    <main>
        <section>
          <ul>
            {questions.map((question, index) => (
              <li key={index}>
                <br />
                <h3 class="question_fontsize">{jsonData[question].question}</h3>
                <textarea
                  class="response-textarea"
                  value={responses[question] || ''}
                  onChange={(e) => handleResponseChange(question, e.target.value)}
                  placeholder="Type your response here..."
                />
              </li>
            ))}
          </ul>
        </section>
      </main>
      <Link to="/skill5">
        <button class="skill_nextButton" onClick={submitResponses} disabled={!allQuestionsAnswered} title={!allQuestionsAnswered ? 'Please enter your answer to proceed' : ''}>Next</button>
      </Link>
    </div>
  );
}

export default Skill4;