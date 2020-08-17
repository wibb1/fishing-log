import React from 'react';
import { Link } from 'react-router-dom';

const TripShowTile = ({ trip }) => {
	// debugger
	const success_color = (success) => {
		let success_color;
		if (success === 'Good') {
			success_color = `is-success`;
		} else if (success === 'Bad') {
			success_color = `is-light`;
		}
		return success_color;
	};

	return (
		<div className="tile is-ancestor m-md">
			<div className="tile is-vertical m-md is-fullwidth">
				<div className="tile">
					<div className="tile is is-parent">
						<article
							className={`tile title is-child notification is-fullwidth ${success_color(trip.success)} has-text-dark`}
						>
							<div className="box desktop-m-t-md is-fullwidth">
								<p className="has-text-centered center">{trip.name}</p>
							</div>
						</article>
						<div className="tile is-white is-2 is-child is-vcentered is-centered p-sm">
							<div className="desktop-m-sm p-md">
								<Link to="/trips/react" className="button is-fullwidth is-dark p-sm is-medium">
									Return to list
								</Link>
							</div>
							<div className="desktop-m-sm p-md">
								<a
									href={`/trips/${trip.id}/edit`}
									className="button is-fullwidth is-dark is-medium"
								>
									Edit Spot
								</a>
							</div>
						</div>
					</div>
				</div>
				<div className="tile is-verticle">
					<div className="tile is-vertical">
						<div className="tile">
							<div className="tile is-parent is-vertical">
								<article
									className={`tile is-child notification ${success_color(
										trip.success
									)} has-text-centered`}
								>
									<div className="box">
										<p>
											{trip.date} {trip.time}
										</p>
									</div>
									<div className="box center">
										<table className="table has-text-centered">
											<tbody>
												<tr>
													<td>Species</td>
													<td>{trip.species}</td>
													<td></td>
												</tr>
												<tr>
													<td>Latitude</td>
													<td>{trip.latitude}</td>
													<td>N</td>
												</tr>
												<tr>
													<td>Longitude</td>
													<td>{trip.longitude}</td>
													<td>E</td>
												</tr>
											</tbody>
										</table>
									</div>
								</article>
							</div>
							<div className="tile is-parent">
								<article className={`tile is-child notification ${success_color(trip.success)} center`}>
									<figure className="image is-fullwidth">
										<img src="https://bulma.io/images/placeholders/640x480.png"></img>
									</figure>
								</article>
							</div>
						</div>
						<div className="tile">
							<div className="tile is-parent">
								<article className={`tile is-child center notification ${success_color(trip.success)}`}>
									<div className="box is-fullheight center">
										<h1>{trip.body}</h1>
									</div>
								</article>
							</div>
						</div>
						<div className="tile">
							<div className="tile is-parent">
								<article className={`tile is-child notification ${success_color(trip.success)}`}>
									<div className="box center">
										<table className="table has-text-centered">
											<tbody>
												<tr>
													<td>Moon Fraction</td>
													<td>{trip.astro.moonFraction}</td>
												</tr>
												<tr>
													<td>Moon Phase</td>
													<td>{trip.astro.moonPhase}</td>
												</tr>
												<tr>
													<td>Moonrise</td>
													<td>{trip.astro.moonrise}</td>
												</tr>
												<tr>
													<td>Moonset</td>
													<td>{trip.astro.moonset}</td>
												</tr>
											</tbody>
										</table>
									</div>
								</article>
							</div>
							<div className="tile is-parent">
								<article className={`tile is-child notification ${success_color(trip.success)}`}>
									<div className="box center">
										<table className="table has-text-centered">
											<tbody>
												<tr>
													<td>First Light</td>
													<td>{trip.astro.astronomicalDawn}</td>
												</tr>
												<tr>
													<td>Last Light</td>
													<td>{trip.astro.astronomicalDusk}</td>
												</tr>
												<tr>
													<td>Civil Dawn</td>
													<td>{trip.astro.civilDawn}</td>
												</tr>
												<tr>
													<td>Civil Dusk</td>
													<td>{trip.astro.civilDusk}</td>
												</tr>
												<tr>
													<td>Sunset</td>
													<td>{trip.astro.sunset}</td>
												</tr>
												<tr>
													<td>Sunrise</td>
													<td>{trip.astro.sunrise}</td>
												</tr>
											</tbody>
										</table>
									</div>
								</article>
							</div>
						</div>
					</div>
					<div className="tile is-vertical is-4">
						<div className="tile ">
							<div className="tile is-parent is-vertical ">
								<article className={`tile is-child  notification ${success_color(trip.success)}`}>
									<div className="box center">
										<table className="table has-text-centered">
											<tbody>
												<tr>
													<td>Air Temperature</td>
													<td>{trip.weather.airTemperature}</td>
												</tr>
												<tr>
													<td>Barometric Pressure</td>
													<td>{trip.weather.pressure}</td>
												</tr>
												<tr>
													<td>Cloud Cover</td>
													<td>{trip.weather.cloudCover}</td>
												</tr>
												<tr>
													<td>Visibility</td>
													<td>{trip.weather.visibility}</td>
												</tr>
												<tr>
													<td>Wind Gusts</td>
													<td>{trip.weather.gust}</td>
												</tr>
												<tr>
													<td>Wind Direction</td>
													<td>{trip.weather.windDirection}</td>
												</tr>
												<tr>
													<td>Wind Speed</td>
													<td>{trip.weather.windSpeed}</td>
												</tr>
												<tr>
													<td>Relative Humidity</td>
													<td>{trip.weather.humidity}</td>
												</tr>
											</tbody>
										</table>
									</div>
								</article>
								<article className={`tile is-child notification ${success_color(trip.success)}`}>
									<div className="box center">
										<table className="table has-text-centered">
											<tbody>
												<tr>
													<td>Wave Direction</td>
													<td></td>
												</tr>
												<tr>
													<td>Wave Height</td>
													<td></td>
												</tr>
												<tr>
													<td>Wave Period</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</article>
								<article className={`tile is-child notification ${success_color(trip.success)}`}>
									<div className="box center">
										<table className="table has-text-centered">
											<tbody>
												<tr>
													<td>Sea Level</td>
													<td>{trip.weather.seaLevel}</td>
												</tr>
												<tr>
													<td>Current Direction</td>
													<td>{trip.weather.currentDirection}</td>
												</tr>
												<tr>
													<td>Current Speed</td>
													<td>{trip.weather.currentSpeed}</td>
												</tr>
											</tbody>
										</table>
									</div>
								</article>
								<article className={`tile is-child notification ${success_color(trip.success)}`}>
									<div className="box center">
										<table className="table has-text-centered">
											<tbody>
												<tr>
													<td>{trip.tide.first_type}</td>
													<td>{trip.tide.first_time}</td>
												</tr>
												<tr>
													<td>{trip.tide.second_type}</td>
													<td>{trip.tide.second_time}</td>
												</tr>
												<tr>
													<td>{trip.tide.third_type}</td>
													<td>{trip.tide.third_time}</td>
												</tr>
												<tr>
													<td>{trip.tide.fourth_type}</td>
													<td>{trip.tide.fourth_time}</td>
												</tr>
											</tbody>
										</table>
									</div>
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
