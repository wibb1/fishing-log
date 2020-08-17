import React, { useState, useEffect } from 'react';
import TripShowTile from './TripShowTile';

const TripShowContainer = (props) => {
	const [tripState, setTripState] = useState({
		weather: {}, tide: {}, astro: {}
	});

	const tripId = props.match.params.id;

	useEffect(() => {
		fetch(`/api/v1/trips/${tripId}`)
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
			.then((body) => {
				
				setTripState(body.trip)
				})
			.catch((error) => console.error(`Error in fetch: ${error.message}`));
	}, []);


	return (  
	<TripShowTile
		trip={tripState}
	/>
	);
};

export default TripShowContainer;
