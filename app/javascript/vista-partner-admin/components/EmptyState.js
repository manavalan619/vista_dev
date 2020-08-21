import React, { Component, PropTypes } from 'react'

export default class EmptyState extends Component {
  render() {
    return (
      <div className='empty-state'>
        <p className='text-muted'>{this.props.message}</p>
      </div>
    )
  }
}
