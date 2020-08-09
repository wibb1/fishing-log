import React, { useState, useEffect } from 'react';
import TripShowTile from './TripShowTile';

const TripShowContainer = (props) => {
	const [trip, setTrip] = useState({
		id: "",
		name: "",
		success: "",
		species: "",
		body: "",
		latitude: "",
		longitude: "",
		trip_time: "",
		user_id: "",
		shared: "false"
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
			.then((response) => {
				return response.json();
			})
			.then((body) => {
				setTrip(body.trip);
			})
			.catch((error) => console.error(`Error in fetch: ${error.message}`));
	}, []);

	return (
		<div className="">
			<TripShowTile
				key={trip.id}
				id={trip.id}
				name={trip.name}
				success={trip.success}
				species={trip.species}
				body={trip.body}
				latitude={trip.latitude}
				longitude={trip.longitude}
				trip_time={trip.trip_time}
				user_id={trip.user_id}
				shared={trip.shared}
			/>
		</div>
	);
};

export default TripShowContainer;
