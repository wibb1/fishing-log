import React, { useState, useEffect } from 'react';
import { Redirect } from 'react-router-dom';
//import {
// 	Field,
// 	Control,
// 	Label,
// 	Input,
// 	Textarea,
// 	Select
// } from 'react-bulma-components/lib/components/form';
//import Button from 'react-bulma-components/lib/components/button';
//import Icon from 'react-bulma-components/lib/components/icon';
import _ from 'lodash';

const TripFormContainer = (props) => {
	const [trip, setTrip] = useState({
		name: '',
		success: '',
		species: '',
		body: '',
		latitude: '',
		longitude: '',
		trip_time: '',
		shared: '',
	});
	const [errors, setErrors] = useState({});

  const select = props => {
    <Select>{props.data.map((x,y)=> <option key={x}>{y}</option>)}</Select>
  }

	const validSubmission = () => {
		let submitErrors = {};
		const requiredFields = ['name', 'success', 'species', 'latitude', 'longitude', 'trip_time', 'shared'];
		requiredFields.forEach((field) => {
			if (trip[field].trim() === '') {
				submitErrors = {
					...submitErrors,
					[field]: 'is blank',
				};
			}
		});
		setErrors(submitErrors);
		return _.isEmpty(submitErrors);
	};

	const [shouldRedirect, setShouldRedirect] = useState(false);

	const handleInputChange = (event) => {
		setTrip({
			...trip,
			[event.currentTarget.id]: event.currentTarget.value,
		});
	};

	const onSubmitHandeler = (event) => {
	// 	const lat = trip.latitude;
	// 	const lng = trip.longitude;
	// 	const start = trip.trip_time.to_f * 1000; //don't think this is correct;
	// 	const end = '2018-05-16';
	// 	const params = 'windSpeed';

	// 	fetch(`https://api.stormglass.io/v2/tide/extremes/point?lat=${lat}&lng=${lng}&start=${start}&end=${end}`, {
	// 		headers: {
	// 			Authorization: '4db0ef76-cff8-11ea-9efd-0242ac130002-4db0f048-cff8-11ea-9efd-0242ac130002',
	// 		},
	// 	})
	// 		.then((response) => response.json())
	// 		.then((jsonData) => {
	// 			// Do something with response data.
	// 		});

		event.preventDefault();
		if (validSubmission()) {
			addNewTrip(trip);
		}
	};

	const addNewTrip = (trip) => {
		fetch('api/v1/trips', {
			method: 'POST',
			credentials: 'same-origin',
			headers: {
				Accept: 'application/json',
				'Content-Type': 'application/json',
			},
			body: JSON.stringify(trip),
		})
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
				setShouldRedirect(true);
			})
			.catch((error) => console.error(`Error in fetch: ${error.message}`));
	};

	if (shouldRedirect) {
		return <Redirect to="/trips" />;
	}
	return (
		<div>
			<h1 className="title has-text-light center pt-4">New Trip Log</h1>

			<section className="columns is-4 center">
				<form onSubmit={onSubmitHandeler}>
					<Field>
						<Label htmlFor="name">
							<Control>
								<Input
									type="text"
									id="name"
									name="name"
									className="input"
									placeholder="Name"
									onChange={handleInputChange}
									value={trip.name}
								/>
							</Control>
						</Label>
					</Field>
					<Field>
						<Label htmlFor="species">
							<Control>
								<Select>
									{select}
									onChange={handleInputChange}
									value={trip.species}
								</Select>
							</Control>
						</Label>
					</Field>
					<Field className="column is-4">
						<Label htmlFor="Description">
							<Control>
								<Textarea
									type="text"
									id="body"
									name="body"
									placeholder="Description"
									onChange={handleInputChange}
									value={trip.body}
								/>
							</Control>
						</Label>
					</Field>
					<Field className="column is-4">
						<Label htmlFor="Latitude">
							<Control>
								<Input
									type="number"
									id="latitude"
									name="latitude"
									placeholder="latitude"
									onChange={handleInputChange}
									value={trip.latitude}
								/>
							</Control>
						</Label>
					</Field>

					<Field className="column is-4">
						<Label htmlFor="Longitude">
							<Control>
								<Input
									type="number"
									id="longitude"
									name="longitude"
									placeholder="longitude"
									onChange={handleInputChange}
									value={trip.longitude}
								/>
							</Control>
						</Label>
					</Field>

					<Field className="column is-4">
						<Label htmlFor="Date and Time">
							<Control>
								<Input
									type="time"
									id="time"
									name="time"
									placeholder="time"
									onChange={handleInputChange}
									value={trip.trip_time}
								/>
							</Control>
						</Label>
					</Field>

					<Field className="column is-4">
						<Label htmlFor="Shared">
							<Control>
								<Select>
                  <option>"Shared"</option>
                  <option>"Private"</option>
                  type="shared"
									id="shared"
									name="shared"
									placeholder="shared"
									onChange={handleInputChange}
									value={trip.shared}
								</Select>
							</Control>
						</Label>
					</Field>

					<div className="column is-4">
						<Button className="button-group">
							<Input
								type="submit"
								className="button is-primary has-text-dark has-text-weight-bold"
								value="Submit "
							/>
						</Button>
					</div>
				</form>
			</section>
		</div>
	);
};

export default TripFormContainer;
