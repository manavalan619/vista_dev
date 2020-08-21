import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { DragDropContext } from 'react-beautiful-dnd'
import { PreferenceColumn } from './PreferenceColumn'
import { reorderQuoteMap } from './reorder'

const propTypes = {
  items: PropTypes.array.isRequired,
  left: PropTypes.array.isRequired,
  right: PropTypes.array.isRequired
}

const defaultProps = {
  items: [],
  left: [],
  right: []
}

class RolePreferenceStructure extends Component {
  constructor(props) {
    super(props)

    const leftIds = this.props.left.map(item => parseInt(item.id))
    const rightIds = this.props.right.map(item => parseInt(item.id))

    const available = this.props.items.filter(item => {
      return !leftIds.includes(item.id) && !rightIds.includes(item.id)
    })
    const left = this.props.items.filter(item => leftIds.includes(item.id))
    const right = this.props.items.filter(item => rightIds.includes(item.id))

    left.sort((a, b) => {
      const aPosition = this.props.left.find(item => parseInt(item.id) === a.id)
      const bPosition = this.props.left.find(item => parseInt(item.id) === b.id)
      return parseInt(aPosition.position) - parseInt(bPosition.position)
    })

    right.sort((a, b) => {
      const aPosition = this.props.right.find(item => parseInt(item.id) === a.id)
      const bPosition = this.props.right.find(item => parseInt(item.id) === b.id)
      return parseInt(aPosition.position) - parseInt(bPosition.position)
    })

    this.state = {
      itemMap: {
        available,
        left,
        right
      }
    }
  }

  /**
   * A semi-generic way to handle multiple lists. Matches
   * the IDs of the droppable container to the names of the
   * source arrays stored in the state.
   */
  id2List = {
    available: 'available',
    left: 'left',
    right: 'right'
  }

  getList = id => this.state[this.id2List[id]]

  onDragEnd = result => {
    const { source, destination } = result

    // dropped outside the list
    if (!destination) {
      return
    }

    this.setState(reorderQuoteMap({
      itemMap: this.state.itemMap,
      source,
      destination
    }))
  }

  render() {
    const { itemMap } = this.state

    return (
      <div className="field">
        <label className="label">Preference groups</label>
        <DragDropContext onDragEnd={this.onDragEnd}>
          <div className="columns">
            <div className="column is-4">
              <div className="is-dashed is-fullheight">
                <div className="columns is-fullheight">
                  {itemMap.available.length === 0 &&
                    <div className="drag-placeholder">
                      Drag preference groups here to remove them from role
                    </div>
                  }
                  <PreferenceColumn
                    title='Available'
                    droppableId='available'
                    items={itemMap.available}
                    containerClass="is-12"
                    hasInput={false}
                  />
                </div>
              </div>
            </div>
            <div className="column is-8">
              <div className="is-dashed is-fullheight">
                <div className="columns is-fullheight">
                  {itemMap.left.length === 0 && itemMap.right.length === 0 &&
                    <div className="drag-placeholder">
                      Drag preference groups here to add them to role
                    </div>
                  }
                  <PreferenceColumn
                    title='Left'
                    droppableId='left'
                    items={itemMap.left}
                    hasInput={true}
                  />

                  <PreferenceColumn
                    title='Right'
                    droppableId='right'
                    items={itemMap.right}
                    hasInput={true}
                  />
                </div>
              </div>
            </div>
          </div>
        </DragDropContext>
      </div>
    )
  }
}

RolePreferenceStructure.propTypes = propTypes
RolePreferenceStructure.defaultProps = defaultProps

export default RolePreferenceStructure
