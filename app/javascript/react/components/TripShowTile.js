import React from 'react';
import { Link } from 'react-router-dom';

const TripShowTile = ({ id, name, success, species, body, latitude, longitude, trip_time, user_id, shared }) => {
	
	return (
		<div className="">
			<h1>{name}</h1>
			<h1>{success}</h1>
			<h1>{species}</h1>
			<h1>{body}</h1>
			<h1>{latitude}</h1>
			<h1>{longitude}</h1>
			<h1>{trip_time}</h1>
			<h1>{user_id}</h1>
			<h1>{shared}</h1>
		</div>
	);
};

export default TripShowTile;
