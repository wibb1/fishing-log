import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import ReactDOM from 'react-dom'
import { library } from '@fortawesome/fontawesome-svg-core'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { faThumbsUp, faThumbsDown } from '@fortawesome/free-solid-svg-icons'

import TripsIndexContainer from './TripsIndexContainer';
import TripShowContainer from './TripShowContainer';

library.add(fab, faThumbsUp, faThumbsDown)

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
