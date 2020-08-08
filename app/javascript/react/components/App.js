import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import TripsIndexContainer from './TripsIndexContainer';


export const App = (props) => {
	return (
		<BrowserRouter>
			<Switch>
				<Route exact path="/trips" component={TripsIndexContainer} />
			</Switch>
		</BrowserRouter>
	);
};

export default App;
