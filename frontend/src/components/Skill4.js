import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import jsonData from './QuestionAnswer.json';
import './../App.css';

function Skill4() {
  const questions = Object.keys(jsonData).slice(11, 12);

  // Create a state to store user responses
  const [responses, setResponses] = useState({});

  const handleResponseChange = (question, response) => {
    setResponses({ ...responses, [question]: response });
  };

  return (
    <div>
      <header>
        <h1>Lean production </h1>
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
      <Link to="/skill5">
          <button>Next</button>
    </Link>
    </div>
  );
}

export default Skill4;
