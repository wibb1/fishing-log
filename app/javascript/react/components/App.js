import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import ReactDOM from 'react-dom'

import TripsIndexContainer from './TripsIndexContainer';
import TripShowContainer from './TripShowContainer';
import SearchBar from './SearchBar';

export const App = (props) => {
	return (
		<BrowserRouter>
			<Switch>
				<Route exact path="/trips/react" component={TripsIndexContainer} />
				<Route exact path="/trips/react/:id" component={TripShowContainer} />
			</Switch>
		</BrowserRouter>
	);
};

export default App;
