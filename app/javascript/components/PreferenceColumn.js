import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import { Droppable } from 'react-beautiful-dnd'
import { PreferenceGroup } from './PreferenceGroup'
import PropTypes from 'prop-types'

const propTypes = {
  hasInput: PropTypes.bool
}

const defaultProps = {
  hasInput: false
}

const getListStyle = isDraggingOver => ({
  background: isDraggingOver ? '#ecf0f3' : '',
  // height: '100%',
  borderRadius: '3px',
  width: 'auto'
})

class PreferenceColumn extends Component {
  render() {
    const { droppableId, items, containerClass, hasInput } = this.props

    return (
      <div className={['column', containerClass].join(' ')}>
        <Droppable droppableId={droppableId}>
          {(provided, snapshot) => (
            <div
              className='is-fullheight'
              ref={provided.innerRef}
              style={getListStyle(snapshot.isDraggingOver)}>
              {items.map((item, index) => (
                <PreferenceGroup
                  key={item.id}
                  item={item}
                  index={index}
                  droppableId={droppableId}
                  hasInput={hasInput}
                />
              ))}
              {provided.placeholder}
            </div>
          )}
        </Droppable>
      </div>
    )
  }
}

PreferenceColumn.propTypes = propTypes
PreferenceColumn.defaultProps = defaultProps

export { PreferenceColumn }
