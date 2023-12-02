import React, { useState } from 'react';
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
  const question = "We're giving you an object: a shoelace. In the next 2 minutes, please list as many creative and alternative uses for this shoelace as you can think of. Let's see how imaginative you can be!";

  const [responses, setResponses] = useState(['']);
  const [AssessUserArtAndCreativitySkill] = useMutation(ASSESS_SKILL); 

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
          answer: responses.join(", ")
        },
      });

      console.log('Mutation Response:', response);
    } catch (error) {
      // handle error, e.g., show error message
      console.error('Mutation Error:', error);
    }
  };

  const areAllFilled = responses.every(response => response.trim() !== '');

  return (
    <div>
      <header>
        <h1>Art and Creativity</h1>
        {/* Timer */}
      </header>
      <main>
        <section>
          <h3>{question}</h3>
          {responses.map((response, index) => (
            <div key={index} style={{ display: 'flex', alignItems: 'center', marginBottom: '10px' }}>
              <button onClick={() => removeTextbox(index)} style={{ marginRight: '5px' }}>-</button>
              <textarea
                value={response}
                onChange={(e) => handleResponseChange(index, e.target.value)}
              />
            </div>
          ))}
          <button onClick={addTextbox}>Add More Ideas</button>
          <p>Count: {responses.length}, Texts: {responses.join(", ")}</p>
        </section>
      </main>
      <footer>
        {/* &copy; 2023 My Website */}
      </footer>
      <div className="tooltip">
        <Link to="/skill9_1" style={{ pointerEvents: areAllFilled ? 'auto' : 'none' }}>
          <button disabled={!areAllFilled} onClick={submitResponses}>Next</button>
        </Link>
        {!areAllFilled && <span className="tooltiptext">Please fill in all textboxes to proceed</span>}
      </div>
    </div>
  );
}

export default Skill8;
