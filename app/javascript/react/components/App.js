import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import TripsIndexContainer from './TripsIndexContainer';
import TripShowContainer from './TripShowContainer';

export const App = (props) => {
	return (
		<BrowserRouter>
			<Switch>
				<Route exact path="/trips" component={TripsIndexContainer} />
				<Route exact path="/trips/:id" component={TripShowContainer} />
			</Switch>
		</BrowserRouter>
	);
};

export default App;
