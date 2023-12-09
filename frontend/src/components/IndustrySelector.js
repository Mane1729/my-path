import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import { useNavigate } from 'react-router-dom';
import './../App.css';

import gql from 'graphql-tag';
import { useMutation } from '@apollo/react-hooks';

const DETERMINE_BEST_FIT_JOB = gql`
  mutation DetermineBestFitJob($industries: [String!]) {
    determineBestFitJob(industries: $industries) {
      success
      errors
    }
  }
`;

function IndustrySelector() {
  const [selectedIndustries, setSelectedIndustries] = useState([]);
  const [determineBestFitJob] = useMutation(DETERMINE_BEST_FIT_JOB);

  const industries = [
    "Medicine",
    "Media and entertainment",
    "Tourism and hospitality",
    "Industry",
    "Fashion",
    "Financial sector",
    "Construction",
    "Biotechnologies",
    "Safety",
    "IT sector",
    "Land Transport",
    "Ecology",
    "Food industry",
    "Social sphere",
    "Robotics",
    "Aviation",
    "Water transport",
    "New materials and nanotechnologies",
    "Mining",
    "Power Industry",
    "Agriculture",
    "Space",
    "Neuronet",
    "Management",
    "Metallurgy",
    "Culture and art",
    "Education"
  ];

  const handleIndustryChange = (event) => {
    const { value, checked } = event.target;
    if (checked) {
      setSelectedIndustries([...selectedIndustries, value]);
    } else {
      setSelectedIndustries(selectedIndustries.filter(industry => industry !== value));
    }
  };

  const navigate = useNavigate();

  const submitIndustries = async () => {
    try {
      const response = await determineBestFitJob({
        variables: { industries: selectedIndustries },
      });

      if (response.data.determineBestFitJob.success) {
        navigate('/career_success');
      } else {
        navigate('/career_error');
      }
    } catch (err) {
      console.error('Submission Error:', err);
    }
  };

  const sortedIndustries = industries.sort();

  return (
    <div className="industry-selector-container">
      <header>
        <h1>Congratulations on Completing the Assessments!</h1>
        <p>Please select the industries you are interested in to discover the best fit job for you. It's completely okay if you choose not to select any industry; we will provide recommendations based on your assessments alone.</p>
      </header>
      <main>
        <section>
          <form>
            <div className="checkbox-container">
              {sortedIndustries.map((industry, index) => (
                <label key={index} className="checkbox-label">
                  <input type="checkbox" value={industry} onChange={handleIndustryChange} />
                  {industry}
                </label>
              ))}
            </div>
          </form>
        </section>
      </main>
      <footer>
        <button onClick={submitIndustries} className="submit-button">Discover My Career Path</button>
      </footer>
    </div>
  );
}

export default IndustrySelector;
