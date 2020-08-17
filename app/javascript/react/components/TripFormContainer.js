import React, { useState, useEffect } from 'react';
import { Redirect } from 'react-router-dom';
import _ from 'lodash';

const TripFormContainer = (props) => {
  const [trip, setTrip] = useState({
    name: "",
    success: "",
    species: "",
    body: "",
    latitude: "",
    longitude: "",
    trip_time: "",
    private: ""
  })
  const [errors, setErrors] = useState({})

  const validSubmission = () => {
    let submitErrors = {}
    const requiredFields = ["name", "success", "species", "latitude", "longitude", "trip_time", "private"];
    requiredFields.forEach((field) => {
      if (trip[field].trim() === "") {
        submitErrors = {
          ...submitErrors, [field]: "is blank",
        }
      } 
    })
    setErrors(submitErrors)
    return _.isEmpty(submitErrors)
  }


  const [shouldRedirect, setShouldRedirect] = useState(false);

  const handleInputChange = (event) => {
    setTrip({
      ...trip,
      [event.currentTarget.id]: event.currentTarget.value,
    });
  };

  const onSubmitHandeler = (event) => {

    const lat = trip.latitude;
    const lng = trip.longitude;
    const start = (trip.trip_time.to_f * 1000)//don't think this is correct;
    const end = '2018-05-16';
    const params = 'windSpeed';
    
    fetch(`https://api.stormglass.io/v2/tide/extremes/point?lat=${lat}&lng=${lng}&start=${start}&end=${end}`, {
      headers: {
        'Authorization': '4db0ef76-cff8-11ea-9efd-0242ac130002-4db0f048-cff8-11ea-9efd-0242ac130002'
      }
    })
    .then((response) => response.json())
    .then((jsonData) => {
      // Do something with response data.
    });




    event.preventDefault();
    if (validSubmission()) {
      addNewTrip(trip);
    }
  };

  const addNewTrip = (trip) => {
    fetch('api/v1/trips', {
      method: "POST",
      credentials: "same-origin",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
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
      setShouldRedirect(true)
    })
    .catch((error) => console.error(`Error in fetch: ${error.message}`))
  }

  if (shouldRedirect) {
    return <Redirect to="/trips" />
  }
  return (
    <div>
      <h1 className="title has-text-light center pt-4">New Trip Log</h1>

      <section className="columns is-4 center">

        <form onSubmit={onSubmitHandeler}>

          <div className="label">
            <label htmlFor="name">
              <input
                type="text"
                id="name"
                name="name"
                className="input"
                placeholder="Name"
                onChange={handleInputChange}
                value={trip.name}
              />
            </label>
          </div>
          <div className="column is-4">
            <label htmlFor="species">
              <input
                type="text"
                id="species"
                name="species"
                className="input"
                placeholder="species"
                onChange={handleInputChange}
                value={trip.species}
              />
            </label>
          </div>
          <div className="column is-4">
            <label htmlFor="Description">
              <input
                type="text"
                id="body"
                name="body"
                placeholder="Description"
                onChange={handleInputChange}
                value={trip.body}
              />
            </label>
          </div>
          <div className="column is-4">
            <label htmlFor="Latitude">
              <input
                type="number"
                id="latitude"
                name="latitude"
                placeholder="latitude"
                onChange={handleInputChange}
                value={trip.latitude}
              />
            </label>
          </div>
          
          <div className="column is-4">
            <label htmlFor="Longitude">
              <input
                type="number"
                id="longitude"
                name="longitude"
                placeholder="longitude"
                onChange={handleInputChange}
                value={trip.longitude}
              />
            </label>
          </div>    
          
          <div className="column is-4">
            <label htmlFor="Date and Time">
              <input
                type="time"
                id="time"
                name="time"
                placeholder="time"
                onChange={handleInputChange}
                value={trip.trip_time}
              />
            </label>
          </div> 
          
          <div className="column is-4">
            <label htmlFor="Private">
              <input
                type="private"
                id="private"
                name="private"
                placeholder="private"
                onChange={handleInputChange}
                value={trip.private}
              />
            </label>
          </div>          
          
          <div className="column is-4">
            <div className="button-group">
              <input type="submit" className="button is-primary has-text-dark has-text-weight-bold" value="Submit " />
            </div>
          </div>
        </form>
      </section>
    </div>
  );
};

export default TripFormContainer;

/*
t.string :name,
t.string :success,
t.string :species,
t.text :body
t.decimal :latitude
t.decimal :longitude
t.date :trip_date
t.time :trip_time
t.belongs_to :user,
t.boolean :private, 
*/