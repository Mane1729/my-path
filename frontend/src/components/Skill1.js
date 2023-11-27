import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import jsonData from './QuestionAnswer.json';
import './../App.css';

function App() {
  const questions = Object.keys(jsonData).slice(0, 6);

  // Create a state to store user responses
  const [responses, setResponses] = useState({});

  const handleResponseChange = (question, response) => {
    setResponses({ ...responses, [question]: response });
  };

// function getSelectedOption() {
//   var options = document.getElementsByName("choice");
//   var selectedOption = null;

//   for (var i = 0; i < options.length; i++) {
//     if (options[i].checked) {
//       selectedOption = options[i].value;
//       break;
//     }
//   }

//   if (selectedOption) {
//     alert("You chose: " + selectedOption);
//   } else {
//     alert("Please select an option.");
//   }
// }


  return (
    <div>
      <header>
        <h1>System thinking</h1>
      </header>
      <main>
        <section>
          <ul>
            {questions.map((question, index) => (
              <li key={index}>
                <br></br>
                <h3>{question}</h3>
                <ul>
                  {jsonData[question].map((answer, answerIndex) => (
                    <li key={answerIndex}>
                      <label>
                        <input
                          type="radio"
                          name={question}
                          value={answer}
                          checked={responses[question] === answer}
                          onChange={() => handleResponseChange(question, answer)}
                        />
                        {answer}
                      </label>
                    </li>
                  ))}
                </ul>
              </li>
            ))}
          </ul>
        </section>
      </main>
      <footer>
        {/* &copy; 2023 My Website */}
      </footer>
      <Link to="/skill2">
        <button>Next</button>
      </Link>
    </div>
  );
}

export default App;
