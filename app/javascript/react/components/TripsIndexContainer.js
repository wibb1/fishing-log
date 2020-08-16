import React, { useState, useEffect } from 'react';

import TripTile from './TripTile';

const TripsIndexContainer = (props) => {
	const [trips, setTrips] = useState([]);

	const [user, setUser] = useState([]);

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
				setTrips(response.trips.trips);
				setUser(response.user);
			})
			.catch((error) => console.error(`error in fetch: ${error.message}`));
	}, []);
	
	const tripTiles = trips.map((trip) => {
    
		return (
			<TripTile
				key={trip.id}
				id={trip.id}
				moonFraction={trip.astro.moonFraction}
				moonPhase={trip.astro.moonPhase}
				sunset={trip.astro.sunset}
				name={trip.name}
				success={trip.success}
				species={trip.species}
				body={trip.body}
				latitude={trip.latitude}
				longitude={trip.longitude}
				date={trip.date}
				time={trip.time}
				pressure={trip.weather.pressure}
				humidity={trip.weather.humidity}
				windDirection={trip.weather.windDirection}
				windSpeed={trip.weather.windSpeed}
				firstTime={trip.tide.first_time}
				secondTime={trip.tide.second_time}
				thirdTime={trip.tide.third_time}
				fourthTime={trip.tide.first_time}
				firstType={trip.tide.first_type}
				secondType={trip.tide.second_type}
				thirdType={trip.tide.third_type}
				fourthType={trip.tide.fourth_type}
				dawn={trip.astro.civilDawn}
				dusk={trip.astro.civilDusk}
				first_light={trip.astro.astronomicalDawn}
				last_light={trip.astro.astronomicalDusk}
			/>
		);
	});

	return (
		<div>
			<div className="">
			<h1 className="title center m-md"> Your Spot List</h1>
			</div>
			{tripTiles}
		</div>
	);
};

export default TripsIndexContainer;
