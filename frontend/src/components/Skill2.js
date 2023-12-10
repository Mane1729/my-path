import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import jsonData from './questionData/ProjectManagementQuestions.json';
import './../App.css';

import gql from 'graphql-tag';
import { useMutation } from '@apollo/react-hooks';

const ASSESS_SKILL = gql`
  mutation AssessUserProjectManagemenSkill($answer: String!) {
    assessUserProjectManagementSkill(answer: $answer) {
      success
      errors
    }
  }
`;

function Skill2() {
  const questions = Object.keys(jsonData);
  const [responses, setResponses] = useState({});
  const [allQuestionsAnswered, setAllQuestionsAnswered] = useState(false);
  const [AssessUserProjectManagemenSkill] = useMutation(ASSESS_SKILL);

  useEffect(() => {
    checkAllQuestionsAnswered();
  }, [responses]);

  const handleResponseChange = (question, response) => {
    setResponses({ ...responses, [question]: response });
  };

  const mapResponsesToMutationFormat = () => {
    return responses;
  };

  const checkAllQuestionsAnswered = () => {
    const answered = questions.every((question) => responses[question] !== undefined && responses[question].trim() !== '');
    setAllQuestionsAnswered(answered);
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
    <header>
      <h1>Project management</h1>
    </header>
    <main>
        <section>
          <img src='frontend\src\Icons\ProjectManagement.png'/>
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
      <Link to="/skill3">
      <button className="skill_nextButton" onClick={submitResponses} disabled={!allQuestionsAnswered}>Next</button>
    </Link>
    </div>
  );
}

export default Skill2;