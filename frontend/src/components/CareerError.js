import './../App.css';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import errorIcon from '../Images/error_icon.png';

function CareerError() {
  return (
    <div>
      <header>
      <img src={errorIcon} alt="Error_Icon" />
        <h1>Oops! Something Went Wrong</h1>
        <p>Unfortunately, we couldn't find a suitable job match based on the current data.</p>
        <p>Please try again later.</p>
      </header>
      <Link to="/">
        <button class="skill_nextButton">Back to Home</button>
      </Link>
    </div>
  );
}

export default CareerError;