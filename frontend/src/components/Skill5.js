import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import jsonData from './questionData/CustomerFocusQuestions.json';
import './../App.css';
import CustomerFocus from '../Icons/CustomerFocus.png';


import gql from 'graphql-tag';
import { useMutation } from '@apollo/react-hooks';

const ASSESS_SKILL = gql`
  mutation AssessUserCustomerFocusSkill($answers: CustomerFocusQuestionnaireInput!) {
    assessUserCustomerFocusSkill(answers: $answers) {
      success
      errors
    }
  }
`;

function App() {
  const questionsData = jsonData;
  const [responses, setResponses] = useState({});
  const [allQuestionsAnswered, setAllQuestionsAnswered] = useState(false);

  const handleResponseChange = (questionKey, choice) => {
    setResponses({ ...responses, [questionKey]: choice });
  };

  useEffect(() => {
    checkAllQuestionsAnswered();
  }, [responses]);

  const mapResponsesToMutationFormat = () => {
    const mappedResponses = {};
    for (const questionKey in responses) {
      if (responses.hasOwnProperty(questionKey)) {
        mappedResponses[questionKey] = responses[questionKey];
      }
    }
    return mappedResponses;
  };

  const checkAllQuestionsAnswered = () => {
    const answered = Object.keys(questionsData).every(
      (questionKey) => responses[questionKey] !== undefined
    );
    setAllQuestionsAnswered(answered);
  };

  const [AssessUserCustomerFocusSkill] = useMutation(ASSESS_SKILL);

  const submitResponses = async () => {
    try {
      const mappedResponses = mapResponsesToMutationFormat();

      console.log('Collected Responses:', responses);
      console.log('Mapped Responses for Mutation:', mappedResponses);

      const response = await AssessUserCustomerFocusSkill({
        variables: {
          answers: mappedResponses,
        },
      });

      // handle response, e.g., navigate to another page or show success message
    } catch (error) {
      // handle error, e.g., show error message
    }
  };

  return (
    <div class="skill">
    <header class="header">
    <div>
      <img className="icon" src={CustomerFocus}/>
      </div>
      <div  class="headerRight">
      <h1>Customer Focus</h1>
      </div>
      </header>
    <main>
        <section>
          <ul>
            {Object.keys(questionsData).map((questionKey) => (
              <li key={questionKey}>
                <br></br>
                <h3 class="question_fontsize">{questionsData[questionKey].question}</h3>
                <ul>
                  {questionsData[questionKey].options.map((option) => (
                    <li key={option.choice}>
                      <label>
                        <input
                          type="radio"
                          name={questionKey}
                          value={option.choice}
                          checked={responses[questionKey] === option.choice}
                          onChange={() => handleResponseChange(questionKey, option.choice)}
                        />
                        <span class="option_fontsize">{option.text}</span>
                      </label>
                    </li>
                  ))}
                </ul>
              </li>
            ))}
          </ul>
        </section>
      </main>
      <Link to="/skill6">
          <button class="skill_nextButton" onClick={submitResponses} disabled={!allQuestionsAnswered} title={!allQuestionsAnswered ? 'Please complete all questions' : ''}>Next</button>
      </Link>
    </div>
  );
}

export default App;