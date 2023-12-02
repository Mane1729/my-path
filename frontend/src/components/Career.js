import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import jsonData from './SystemsThinkingQuestions.json';
import './../App.css';

function App() {
  const questions = Object.keys(jsonData).slice(0, 6);
  const [responses, setResponses] = useState({}); // Initialize responses state

  const handleResponseChange = (question, response) => {
    setResponses({ ...responses, [question]: response });
  };

function getSelectedOption() {
  var options = document.getElementsByName("choice");
  var selectedOption = null;

  for (var i = 0; i < options.length; i++) {
    if (options[i].checked) {
      selectedOption = options[i].value;
      break;
    }
  }

  if (selectedOption) {
    alert("You chose: " + selectedOption);
  } else {
    alert("Please select an option.");
  }
}


  return (
    <div>
      <header>
        <h1>Future Career</h1>
      </header>
      <main>
        
      </main>
      <footer>
        &copy; 2023 My Website
      </footer>
    </div>
  );
}

export default App;
