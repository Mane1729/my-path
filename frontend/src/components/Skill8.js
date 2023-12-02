import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import jsonData from './SystemsThinkingQuestions.json';
import './../App.css';

function Skill2() {
  const questions = Object.keys(jsonData).slice(30, 31);

  // Create a state to store user responses
  const [responses, setResponses] = useState({});

  const handleResponseChange = (question, response) => {
    setResponses({ ...responses, [question]: response });
  };

  return (
    <div>
      <header>
        <h1>Art and Creativity </h1>
        {/* Timer */}
      </header>
      <main>
        <section>
          <ul>
            {questions.map((question, index) => (
              <li key={index}>
                <br></br><h3>{question}</h3>
                <input
                  type="text"
                  value={responses[question] || ''}
                  onChange={(e) => handleResponseChange(question, e.target.value)}
                />
              </li>
            ))}
          </ul>
        </section>
      </main>
      <footer>
        {/* &copy; 2023 My Website */}
      </footer>
      <Link to="/skill9_1">
          <button>Next</button>
    </Link>
    </div>
  );
}

export default Skill2;
