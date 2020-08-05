import React from 'react'

const TripTile = (props) => {
  return (
    <div className="card"> 
      <div className="card-content">
        <div className="media">
          <div className="media-left">
            <p className="title is-4">{props.success}</p>
          </div>
          <div className="media-content">
            <p className="title is-4">{props.name}</p>
            <p className="subtitle is-6">{props.species}</p>
          </div>
          <div className="content">
            <p>{props.body}</p>
          </div>
        </div>
      </div>  
    </div>
  )}

export default TripTile