import React, { Component } from 'react'
import PropTypes from 'prop-types'
import Select from 'react-select'
import 'react-select/dist/react-select.css'
import { withErrorBoundary } from './ErrorBoundary'

class StaffBranchPicker extends Component {
  constructor(props) {
    super(props)
    this.state = {
      businessUnitId: this.props.businessUnitId,
      branchId: this.props.branchId
    }
  }

  selectChange = (name, selection) => {
    this.setState({ [name]: selection.value })
  }

  render () {
    const { businessUnitId, branchId } = this.state
    const { memberType } = this.props

    const businessUnits = this.props.businessUnits.map(unit => {
      return { value: unit.id, label: unit.name }
    })

    const branches = this.props.branches.reduce((array, branch) => {
      if (branch.business_unit_id === this.state.businessUnitId) {
        array.push({ value: branch.id, label: branch.name })
      }
      return array
    }, [])

    return (
      <div>
        <div className="form-group">
          <label htmlFor={`${memberType}_buid`} className="control-label">Business unit</label>
          <Select
            id={`${memberType}_buid`}
            name={null}
            value={businessUnitId}
            onChange={(option) => this.selectChange('businessUnitId', option)}
            options={businessUnits}
          />
        </div>

        <div className="form-group">
          <label htmlFor={`${memberType}_bid`} className="control-label">Branch</label>
          <Select
            id={`${memberType}_bid`}
            name={`${memberType}[branch_id]`}
            value={branchId}
            onChange={(option) => this.selectChange('branchId', option)}
            options={branches}
          />
        </div>
      </div>
    )
  }
}

StaffBranchPicker.propTypes = {
  businessUnits: PropTypes.array.isRequired,
  branches: PropTypes.array.isRequired,
  memberType: PropTypes.string.isRequired
}

export default withErrorBoundary(StaffBranchPicker)
