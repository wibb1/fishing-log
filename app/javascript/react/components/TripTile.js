import React from 'react'
import { Link } from 'react-router-dom'

const TripTile = ({ id, success, name, species, body }) => {
  return (
    <div className="card"> 
      <div className="card-content">
        <div className="media">
          <div className="media-left">
            <p className="title is-4">{success}</p>
          </div>
          <div className="media-content">
            <Link to={`/trips/${id}`} className="title is-4">{name}</Link>
            <br></br>
            <p className="subtitle is-6">{species}</p>
          </div>
          <div className="content">
            <p>{body}</p>
          </div>
        </div>
      </div>  
    </div>
  )}

export default TripTile