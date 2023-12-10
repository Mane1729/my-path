import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import './../App.css';

import gql from 'graphql-tag';
import { useMutation } from '@apollo/react-hooks';

const ASSESS_SKILL = gql`
  mutation AssessUserArtAndCreativitySkill($ideaCount: Int!, $answer: String!) {
    assessUserArtAndCreativitySkill(ideaCount: $ideaCount, answer: $answer) {
      success
      errors
    }
  }
`;

function Skill8() {
  const question =
    "We're giving you an object: a shoelace. In the next 2 minutes, please list as many creative and alternative uses for this shoelace as you can think of. Let's see how imaginative you can be!";

  const [responses, setResponses] = useState(['']);
  const [AssessUserArtAndCreativitySkill] = useMutation(ASSESS_SKILL);
  const [timer, setTimer] = useState(120); // 2 minutes in seconds

  const handleResponseChange = (index, value) => {
    const updatedResponses = [...responses];
    updatedResponses[index] = value;
    setResponses(updatedResponses);
  };

  const addTextbox = () => {
    setResponses([...responses, '']);
  };

  const removeTextbox = (index) => {
    const updatedResponses = [...responses];
    updatedResponses.splice(index, 1);
    setResponses(updatedResponses);
  };

  const submitResponses = async () => {
    try {
      const response = await AssessUserArtAndCreativitySkill({
        variables: {
          ideaCount: responses.length,
          answer: responses.join(', '),
        },
      });

      console.log('Mutation Response:', response);
    } catch (error) {
      // handle error, e.g., show error message
      console.error('Mutation Error:', error);
    }
  };

  const areAllFilled = responses.every((response) => response.trim() !== '');

  useEffect(() => {
    const interval = setInterval(() => {
      setTimer((prevTimer) => {
        if (prevTimer === 0) {
          clearInterval(interval);
          // Redirect to the next page when the timer reaches 0
          window.location.href = '/skill9_1';
        }
        return prevTimer - 1;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, []);

  const isFilled = areAllFilled || responses.length === 0;

  return (
    <div className="skill">
      <header>
        <h1>Art and Creativity</h1>
      </header>
      <main>
        <section>
          <h3 className="question_fontsize">{question}</h3>
          <div>Time remaining: {Math.floor(timer / 60)}:{(timer % 60).toLocaleString('en-US', { minimumIntegerDigits: 2 })}</div>
          {responses.map((response, index) => (
            <div key={index} style={{ display: 'flex', alignItems: 'center', marginBottom: '10px' }}>
              <button onClick={() => removeTextbox(index)} style={{ marginRight: '5px' }}>
                -
              </button>
              <textarea
                className="response-textarea-art"
                value={response}
                onChange={(e) => handleResponseChange(index, e.target.value)}
                placeholder="Type your response here..."
              />
            </div>
          ))}
          {!isFilled && <p>Please write something before submitting.</p>}
          <button onClick={addTextbox}>Add More Ideas</button>
        </section>
      </main>
      <Link to="/skill9_1">
        <button className="skill_nextButton" onClick={submitResponses} disabled={!isFilled}>
          Next
        </button>
      </Link>
    </div>
  );
}

export default Skill8;