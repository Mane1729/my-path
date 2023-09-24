import React, { useState } from 'react';
import gql from 'graphql-tag';
import { useMutation } from '@apollo/react-hooks';

const UPDATE_USER_WORKING_HOURS = gql`
mutation UpdateUserWorkingHours($id: ID!, $workingHours: Int!) {
  updateUserWorkingHours(input: { id: $id, workingHours: $workingHours } ) {
    user {
      id
      workingHours
    }
    success
    errors
  }
}
`;

function UpdateUserWorkingHours() {
  const [userId, setUserId] = useState('');
  const [workingHours, setWorkingHours] = useState('');

  const [updateUserWorkingHours, { data, error, loading }] = useMutation(UPDATE_USER_WORKING_HOURS);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!userId || !workingHours) return;

    try {
      await updateUserWorkingHours({ variables: { id: userId, workingHours: parseInt(workingHours) } });
    } catch (err) {
      console.error("Error updating working hours", err);
    }
  };

  return (
    <div>
      <h2>Update Working Hours</h2>
      <form onSubmit={handleSubmit}>
        <label>
          User ID:
          <input type="text" value={userId} onChange={(e) => setUserId(e.target.value)} />
        </label>
        <label>
          Working Hours:
          <input type="number" value={workingHours} onChange={(e) => setWorkingHours(e.target.value)} />
        </label>
        <button type="submit">Update</button>
      </form>
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error.message}</p>}
      {data && data.updateUserWorkingHours.success && <p>Working hours updated successfully!</p>}
      {data && data.updateUserWorkingHours.errors.length > 0 && <p>{data.updateUserWorkingHours.errors.join(', ')}</p>}
    </div>
  );
}

export default UpdateUserWorkingHours;