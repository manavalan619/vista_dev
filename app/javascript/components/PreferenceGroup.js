import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import { Draggable } from 'react-beautiful-dnd'
import PropTypes from 'prop-types'

const propTypes = {
  item: PropTypes.object.isRequired,
  index: PropTypes.number.isRequired
}

const getItemStyle = (isDragging, draggableStyle) => ({
  // some basic styles to make the items look a bit nicer
  userSelect: 'none',

  // change background colour if dragging
  background: isDragging ? 'lightgreen' : '',

  // styles we need to apply on draggables
  ...draggableStyle
})

class PreferenceGroup extends Component {
  render() {
    const { item, index, droppableId, hasInput } = this.props

    return (
      <Draggable
        key={item.id}
        draggableId={item.id}
        index={index}>
        {(provided, snapshot) => (
          <div
            className="card preference-group mb-1"
            ref={provided.innerRef}
            {...provided.draggableProps}
            {...provided.dragHandleProps}
            style={getItemStyle(
              snapshot.isDragging,
              provided.draggableProps.style
            )}>
            <div className="card-content">
              <p className="title is-5">{item.title}</p>
              <small>
                <ul className="has-bullets">
                  {item.questions.map(question => <li key={question}>{question}</li>)}
                </ul>
              </small>
              {hasInput && <input
                type="hidden"
                name={`role[preference_structure_${droppableId}][][id]`}
                value={item.id}
              />}
              {hasInput && <input
                type="hidden"
                name={`role[preference_structure_${droppableId}][][position]`}
                value={index}
              />}
            </div>
          </div>
        )}
      </Draggable>
    )
  }
}

PreferenceGroup.propTypes = propTypes

export { PreferenceGroup }
