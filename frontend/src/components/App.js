import './../App.css';
//import React from 'react';
import Users from './/Users';
import UpdateUserWorkingHours from './/UpdateUserWorkingHours';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Skill1 from './/Skill1';
import Skill2 from './/Skill2';
import Skill3 from './/Skill3';
import React, { useState } from 'react';
import gql from 'graphql-tag';
import { useMutation } from '@apollo/react-hooks';

const CREATE_USER = gql`
mutation CreateUser {
  createUser(input: { } ) {
    id
    success
    errors
  }
}
`;

class App extends React.Component {
  render() {
    return (
      <Router>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/skill1" element={<Skill1 />} />
          <Route path="/skill2" element={<Skill2 />} />
          <Route path="/skill3" element={<Skill3 />} />
        </Routes>
      </Router>
    );
  }
}

function Home() {
  const [createUser, { loading }] = useMutation(CREATE_USER);

  const handleStartButtonClick = async () => {
    try {
      const response = await createUser();
      if (response.data.createUser.success) {
        // Store the user ID in the local storage
       // localStorage.setItem('userId', response.data.createUser.id);

        // Redirect to the next page
        //window.location.href = '/next-page';

      } else {
        console.log('Errors:', response.data.createUser.errors);
      }
    } catch (error) {
      console.error('Error creating user:', error);
    }
  };

  return (
    <div>
      <Link to="/skill1">
      <button onClick={handleStartButtonClick} disabled={loading}>Start</button>
      </Link>
    </div>
  );
}


// function Home() {
//   return (
//     <div>
//       <Link to="/skill1">
//         <button>Start</button>
//       </Link>
//     </div>
//   );
// }

export default App;
