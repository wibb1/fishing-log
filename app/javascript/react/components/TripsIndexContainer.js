import React, { useState, useEffect } from 'react';

import TripTile from './TripTile';

const TripsIndexContainer = (props) => {
  const [trips, setTrips] = useState([]);

  const [user, setUser] =useState([])
  
	useEffect(() => {
    fetch('/api/v1/trips')
      .then((response) => {
    	  if (response.ok) {
				  return response;
			  } else {
				  let errorMessage = `${response.status} (${response.statusText})`,
					  error = new Error(errorMessage);
				  throw error;
			  }
      })
      .then((response) => response.json())
      .then((response) => {
        setTrips(response.trips)
        setUser(response.user)
      })
      .catch((error) => console.error(`error in fetch: ${error.message}`))
  }, []);
  
  const tripTiles = trips.map((trip) => {
    return (
      <TripTile
        key={trip.id}
        id={trip.id}
        name={trip.name}
        success={trip.success}
        species={trip.species}
        body={trip.body}
        latitude={trip.latitude}
      />
    )
  })

  return (
    <div className="container">
      <div>
        {tripTiles}
      </div>
    </div>
  )
};

export default TripsIndexContainer