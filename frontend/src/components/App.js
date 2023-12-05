import './../App.css';
//import React from 'react';
import Users from './/Users';
import UpdateUserWorkingHours from './/UpdateUserWorkingHours';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Skill1 from './/Skill1';
import Skill2 from './/Skill2';
import Skill3 from './/Skill3';
import Skill4 from './/Skill4';
import Skill5 from './/Skill5';
import Skill6 from './/Skill6';
import Skill7 from './/Skill7';
import Skill8 from './/Skill8';
import Skill9_1 from './/Skill9_1';
import Skill9_2 from './/Skill9_2';
import Skill10 from './/Skill10';
import Skill11 from './/Skill11';
import Career from './/Career';

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
          <Route path="/skill4" element={<Skill4 />} />
          <Route path="/skill5" element={<Skill5 />} />
          <Route path="/skill6" element={<Skill6 />} />
          <Route path="/skill7" element={<Skill7 />} />
          <Route path="/skill8" element={<Skill8 />} />
          <Route path="/skill9_1" element={<Skill9_1 />} />
          <Route path="/skill9_2" element={<Skill9_2 />} />
          <Route path="/skill10" element={<Skill10 />} />
          <Route path="/skill11" element={<Skill11 />} />
          <Route path="/career" element={<Career />} />
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
    
      
      
      <div class="back_image">

          <Link to="/skill1">
            <button class="buttonStart" onClick={handleStartButtonClick} disabled={loading}></button>
        
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
