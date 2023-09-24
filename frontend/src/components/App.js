// import './App.css';
import React from 'react';
import Users from './/Users';
import UpdateUserWorkingHours from './/UpdateUserWorkingHours';

class App extends React.Component {
  state = {
    showUpdateWorkingHours: false,
  };

  handleToggleUpdateWorkingHours = () => {
    this.setState((prevState) => ({ showUpdateWorkingHours: !prevState.showUpdateWorkingHours }));
  };

  render() {
    const { showUpdateWorkingHours } = this.state;

    return (
      <div className="container mx-auto px-4">
        <h1 className="text-center my-4">Users</h1>
        <Users />
        <button onClick={this.handleToggleUpdateWorkingHours} className="my-4 px-4 py-2 bg-blue-500 text-white cursor-pointer">
          Toggle Update Working Hours
        </button>
        {showUpdateWorkingHours && <UpdateUserWorkingHours />}
      </div>
    );
  }
}

// export default Users;
export default App;
