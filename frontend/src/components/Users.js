import React from 'react';
import { useQuery } from '@apollo/react-hooks';
import gql from 'graphql-tag'

const GET_USERS = gql`
  {
    users {
      id
      workingHours
    }
  }
`;

function Users(){
  const { loading, error, data } = useQuery(GET_USERS);

  if(loading) return 'Loading...';
  if(error) return `Error ${error.message}`;

  console.log(data);
  return(
    <div className="flex flex-wrap items-center pb-16" >
      {data.users.map(user => (
        <div key={user.id} className="lg:w-1/3 w-full p-4 text-center inline">
          {user.workingHours}
        </div>  
      ))}
    </div>
  )
}

export default Users;
