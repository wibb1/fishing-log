import React from 'react'

const TripTile = (props) => {
  return (
    <div className="trip-tile"> 
      <p>{props.name}</p>
      <p>{props.success}</p>
      <p>{props.species}</p>
      <p>{props.body}</p>
    </div>
  )}

export default TripTile