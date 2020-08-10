import React from 'react'
import { Link } from 'react-router-dom'

const TripTile = ({ id, success, name, species, body, latitude, longitude, trip_time, user_id, shared }) => {
  let success_class
  if (success === "good") {
    success_class="fas fa-thumbs-up"
  } else {
    success_class="fas fa-thumbs-down"
  }

  return (
    <div className="card"> 
      <div className="card-content">
        <div className="media">
          <div className="media-left">
            <i className="success_class"></i>
          </div>
          <div className="media-content">
            <Link to={`/trips/${id}`} className="title is-4">{name}</Link>
            <br></br>
            <p className="subtitle is-6">{species}</p>
          </div>
          <div className="content">
            <p>{body}</p>
          </div>
          <div>
            <p>{latitude}</p>
            <p>{longitude}</p>
            <p>{trip_time}</p>
            <p>{user_id}</p>
            <p>{shared}</p>
          </div>
        </div>
      </div>  
    </div>
  )}

export default TripTile