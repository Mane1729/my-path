import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import jsonData from './questionData/MulticulturalismQuestions.json';
import './../App.css';
import { useLocation } from 'react-router-dom';

import gql from 'graphql-tag';
import { useMutation } from '@apollo/react-hooks';

const ASSESS_SKILL = gql`
  mutation AssessUserMultilingualismMulticulturalismSkill($multilingualismCorrectCount: Int!, $multiculturalismAnswers: MulticulturalismQuestionnaireInput!) {
    assessUserMultilingualismMulticulturalismSkill(multilingualismCorrectCount: $multilingualismCorrectCount, multiculturalismAnswers: $multiculturalismAnswers) {
      success
      errors
    }
  }
`;

function Skill9_2() {
  const questionsData = jsonData;
  const [responses, setResponses] = useState({});
  const [allQuestionsAnswered, setAllQuestionsAnswered] = useState(false);

  const location = useLocation();
  const correctCount = location.state?.correctCount || 0;

  useEffect(() => {
    checkAllQuestionsAnswered();
  }, [responses]);

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

  const checkAllQuestionsAnswered = () => {
    const answered = Object.keys(questionsData).every(
      (questionKey) => responses[questionKey] !== undefined
    );
    setAllQuestionsAnswered(answered);
  };
  
  const [assessUserMultilingualismMulticulturalismSkill] = useMutation(ASSESS_SKILL);

  const submitResponses = async () => {
    try {
      const mappedResponses = mapResponsesToMutationFormat();

      console.log('Collected Responses:', responses);
      console.log('Mapped Responses for Mutation:', mappedResponses);

      const response = await assessUserMultilingualismMulticulturalismSkill({
        variables: {
          multilingualismCorrectCount: correctCount,
          multiculturalismAnswers: mappedResponses,
        },
      });

      // handle response, e.g., navigate to another page or show success message
    } catch (error) {
      // handle error, e.g., show error message
    }
  };

  return (
      <div className="skill">
        <header>
          <h1>Multiculturalism</h1>
        </header>
        <main>
          <section>
            <ul>
              {Object.keys(questionsData).map((questionKey) => (
                <li key={questionKey}>
                  <br />
                  <h3 className="question_fontsize">{questionsData[questionKey].question}</h3>
                  {questionsData[questionKey].image && (
                    <img
                      src={process.env.PUBLIC_URL + questionsData[questionKey].image}
                      style={{ maxWidth: '100%' }}
                    />
                  )}
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
                          <span className="option_fontsize">{option.text}</span>
                        </label>
                      </li>
                    ))}
                  </ul>
                </li>
              ))}
            </ul>
          </section>
        </main>
      {/* <section>
        <h2>Collected Responses:</h2>
        <pre>{JSON.stringify(responses, null, 2)}</pre>
      </section> */}
        <Link to="/skill10">
          <button class="skill_nextButton" onClick={submitResponses} disabled={!allQuestionsAnswered}>Next</button>
        </Link>
      </div>
  );
}

export default Skill9_2;
