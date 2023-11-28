import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import jsonData from './SystemsThinkingQuestions.json';
import './../App.css';
import Skill2 from './Skill2';

import gql from 'graphql-tag';
import { useMutation } from '@apollo/react-hooks';

const CREATE_USER = gql`
  mutation AssessUserSystemsThinkingSkill($answers: SystemsThinkingQuestionnaireInput!) {
    assessUserSystemsThinkingSkill(answers: $answers) {
      success
      errors
    }
  }
`;

function App() {
  const questionsData = jsonData;
  const [responses, setResponses] = useState({});

  const handleResponseChange = (questionKey, choice) => {
    setResponses({ ...responses, [questionKey]: choice });
  };

  const mapResponsesToMutationFormat = () => {
    const mappedResponses = {};
    for (const questionKey in responses) {
      if (responses.hasOwnProperty(questionKey)) {
        mappedResponses[questionKey] = responses[questionKey];
      }
    }
    return mappedResponses;
  };

  const [assessUserSystemsThinkingSkill] = useMutation(CREATE_USER);

  const submitResponses = async () => {
    try {
      const mappedResponses = mapResponsesToMutationFormat();

      console.log('Collected Responses:', responses);
      console.log('Mapped Responses for Mutation:', mappedResponses);

      const response = await assessUserSystemsThinkingSkill({
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
    <div>
      <header>
        <h1>System thinking</h1>
      </header>
      <main>
        <section>
          <ul>
            {Object.keys(questionsData).map((questionKey) => (
              <li key={questionKey}>
                <br></br>
                <h3>{questionsData[questionKey].question}</h3>
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
                        {option.text}
                      </label>
                    </li>
                  ))}
                </ul>
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
      <div>
        <Link to="/skill2">
          <button onClick={submitResponses}>Next</button>
        </Link>
      </div>
    </div>
  );
}

export default App;