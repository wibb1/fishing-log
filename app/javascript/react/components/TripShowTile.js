import React from 'react';
import { Link } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

const TripShowTile = ({ id, name, success, species, body, latitude, longitude, trip_time, user_id, shared }) => {
	const success_icon = (success) => {
		let success_icon;
		if (success === 'good') {
			success_icon = ['fas', 'thumbs-up'];
		} else {
			success_icon = ['fas', 'thumbs-down'];
		}
		return success_icon;
	};
	const private_message = (shared) => {
		let privacy;
		if (shared) {
			privacy = 'This is a shared spot';
		} else {
			privacy = 'This is not a shared spot';
		}
		return privacy;
	};

	return (
		<div className="tile is-ancestor p-md is-family-monospace">
			<div className="tile is-vertical">
				<div className="tile is-parent">
					<article className="tile is-child notification is-primary">
						<h1 className="has-text-centered">{private_message(shared)}</h1>
					</article>
				</div>
				<div className="tile">
					<div className="tile is-vertical">
						<div className="tile is-parent">
							<article className="tile is-child notification is-primary">
								<p>Weather Data</p>
							</article>
						</div>
					</div>

					<div className="tile is-vertical">
						<div className="tile">
							<div className="tile is-parent is-vertical">
								<article className="tile is-child notification is-primary">
									<h1> Date: {trip_time}</h1>
									<h1> Time: {trip_time}</h1>
								</article>
								<article className="tile is-child notification is-primary">{name}</article>
							</div>

							<div className="tile is-parent">
								<article className="tile is-child notification is-primary">Picture</article>
							</div>
						</div>

						<div className="tile">
							<div className="tile is-parent">
								<article className="tile is-child notification is-primary">
									<p>{success}</p>
									<FontAwesomeIcon icon={success_icon(success)} />
								</article>
							</div>

							<div className="tile is-parent">
								<article className="tile is-child notification is-primary">
									<h1>Species: {species}</h1>
								</article>
							</div>

							<div className="tile is-parent">
								<article className="tile is-child notification is-primary">
									<h1>Location</h1>
									<h1>{latitude} N</h1>
									<h1>{longitude} E</h1>
								</article>
							</div>
						</div>

						<div className="tile">
							<div className="tile is-parent">
								<article className="tile is-child notification is-primary">
									<h1>Description:</h1>
									<h1>{body}</h1>
								</article>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	);
};

export default TripShowTile;
