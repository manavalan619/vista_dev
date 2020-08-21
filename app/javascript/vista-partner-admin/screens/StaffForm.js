import React, { Component } from 'react'
import { Button } from 'reactstrap'
import axios from 'axios'
import serialize from 'form-serialize'
import { staffForm } from '../validation/validation'
import FormContainer from '../components/FormContainer'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'
import Promise from 'bluebird'
import _ from 'lodash'
import { staffMembers } from '../field-control'
import FormButtons from '../components/FormButtons'
import ArchiveModal from '../components/ArchiveModal'
import Select from 'react-select'

const { fields, extraFields } = staffMembers

class StaffForm extends Component {
  constructor(props){
    super(props)
    Promise.promisifyAll(this)
    this.state = {
      accessLevel: 'branch_manager',
      dataLoaded: false,
      validationErrors: [],
      isEditing: false,
      archiveModal: false,
      userRoles: [],
      fields
    }
  }

  toggle(evt) {
    evt.preventDefault()
    this.setState({ archiveModal: !this.state.archiveModal })
  }

  componentWillMount() {
    const { url, params } = this.props.match
    this.setStateAsync({
      isEditing: url.split('/').slice(-1)[0] === 'edit'
    }).then(() => {
      const dbQueries = [
        axios.get('/roles'),
        axios.get('/units')
      ]
      if (this.state.isEditing) {
        dbQueries.push(axios.get(`/staff/${params.staffId}`))
      }
      return Promise.all(dbQueries)
    }).spread((roles, units, staffMember) => {
      const { data } = units
      let unitsRolesBranches = [ units, roles ]
      const unitID = this.determineUnitForForm(data, staffMember)
      unitsRolesBranches.push(data.length ? axios.get(`/units/${unitID}/branches`) : [])
      if (staffMember) {
        unitsRolesBranches.push(staffMember)
        this.setState({ userRoles: staffMember.data.roles})
      }
      return Promise.all(unitsRolesBranches)
    }).spread((units, roles, branches, staffMember) => {
      const { actions, userType } = this.props
      const { isEditing } = this.state
      actions.fillBranchList(branches.data)
      actions.fillUnitList(units.data)
      actions.fillRoleList(roles.data)
      const branchOptions = this.renderBranchOptions.call(this)
      const roleOptions = this.renderRoleOptions.call(this)
      const unitOptions = this.renderUnitOptions.call(this)
      let newFields = [].concat(fields, unitOptions, branchOptions, roleOptions)
      let includePinFields = isEditing ? false : true
      newFields = newFields.filter((field) => {
        if ((field.name === 'type') && staffMember && staffMember.data[field.name] === 'StaffMember' ) {
          includePinFields = true
        }

        field.value = isEditing ? staffMember.data[field.name] || '' : field.name === 'type' ? 'StaffMember' : '';
        // omits the access level, unit and branch input fields if staffMember not admin level
        return !(~['type','unit','branch'].indexOf(field.name) && userType !== 'Admin') && field
      })
      if (includePinFields){
        let pinFields = extraFields.map((field)=>{
          field.value = staffMember && staffMember.data.pin || ''
          return field
        })
        newFields = [].concat(newFields,  pinFields)

      }

      this.setState({ fields: newFields, dataLoaded: true })
    }).catch(err => console.log(err))
  }

  renderBranchOptions() {
    let options = []

    if (this.props.branches) {
      this.props.branches.map(branch => {
        options.push({ text: branch.name, value: branch.id })
      })
    }
    return {
      name: 'branch',
      type: 'select',
      label: 'Branch',
      options
    }
  }

  renderRoleOptions(){
    let options = this.props.roles //.map(role => ({ name: role.name, role: role.id }))
    return {
      name: 'roles',
      label: 'Branch Role',
      options
    }
  }

  renderUnitOptions(){
    let options = this.props.units.map(unit => ({ text: unit.name, value:unit.id }))
    return {
      name: 'unit',
      type: 'select',
      label: 'Unit',
      options
    }
  }

  determineUnitForForm(units, staffMember){
    if (staffMember && staffMember.data){
      const {data} = staffMember
      data.branch = data.branchid
      delete data.branchid
      return data && data.unit || units[0].id
    }
    return units[0].id
  }

  onSubmit(evt){
    evt.preventDefault()
    const formData = serialize(evt.target, { hash: true })
    formData.role_ids = this.state.userRoles && this.state.userRoles.map( role => role.id) || []
    // console.log('FormData', formData)
    let result = staffForm(evt.target.elements, this.props.userType)
    if (result.length){
      this.setState({ validationErrors: result})
    } else {
      formData.pin = formData.pin1;
      (
        this.state.isEditing ?
        axios.put(`/staff/${this.props.match.params.staffId}`, { staff_member: formData }) :
        axios.post(`/staff`, { staff_member: formData } )
      )
      .then(({data})=>{
        console.log('Data',data)
        this.props.actions.pushFlashMessage({
          text:`Staff member successfully ${this.state.isEditing ? 'edited' : 'added'}.`,
          color: 'success'
        })
        this.props.actions.updateStaffList(data)
        this.resetForm.call(this)
      })
      .catch(err => {

        this.props.actions.pushFlashMessage({
          text:`There was a problem ${this.state.isEditing ? 'editing' : 'adding'} the staff member.`,
          color: 'danger'
        })
      })
    }
  }

  onChangeRoleSelection(evt){
    this.setState({userRoles: evt})
  }

  onChangeSelection({target}){
    if (target.id === 'unit'){
      axios.get(`/units/${target.value}/branches`)
      .then(branches => {
        this.props.actions.fillBranchList(branches.data)
        this.setState({ fields:this.replaceBranchOptions.call(this)})
      })
    } else if (target.id === 'type'){
      this.onChangeAccessLevel.call(this,target)
    }
  }

  resetForm(){
    this.setState({ isEditing: false, fields })
    this.props.history.push('/staff')
  }

  replaceBranchOptions(){
    const { fields } = this.state
    let index = _.findIndex(fields, ({name}) => name === 'branch')
    const branchOptions = this.renderBranchOptions.call(this)
    return [].concat(fields.slice(0,index), branchOptions, fields.slice(index + 1))
  }

  addPinFields(){
    const { fields } = this.state
    return fields.some( field => field.name === 'pin1') ?
      fields :
      [].concat(fields.slice(0,8), extraFields,fields.slice(8))
  }

  removePinFields(){
    const { fields } = this.state
    let index = _.findIndex(fields, ({name}) => name === 'pin1')
    return index >= 0 ? [].concat(fields.slice(0,index), fields.slice(index + 2)) : fields
  }

  onChangeAccessLevel({id, value}){
    this.setState({ fields: this[`${value === 'StaffMember' ? 'add' : 'remove'}PinFields`].call(this)})
    this.setState({ accessLevel: value })
  }

  onArchiveStaffMember(evt) {
    evt.preventDefault()
    const { staffId } = this.props.match.params

    axios.delete(`/staff/${staffId}`)
    .then(response => {
      this.props.actions.archiveStaffMember(staffId)
      this.props.history.push(`/staff`)
      this.props.actions.pushFlashMessage({
        text: `Staff member successfully archived.`,
        color: 'success'
      })
    }).catch(error => {
      console.log(error)
      this.props.actions.pushFlashMessage({
        text: `There was a problem archiving the staff member.`,
        color: 'danger'
      })
    })
  }

  render(){
    if (!this.state.dataLoaded) return null
    return (
      <div>
      <FormContainer
        formTitle={this.state.isEditing ? 'Edit staff member' : 'Create staff member'}
        onChange={this.onChangeSelection.bind(this)}
        onChangeRole={this.onChangeRoleSelection.bind(this)}
        fields={this.state.fields}
        onSubmit={this.onSubmit.bind(this)}
        validationErrors={this.state.validationErrors}
        roles={this.state.userRoles}
      >
        <FormButtons
          userType={this.props.userType}
          isEditing={this.state.isEditing}
          onArchive={this.toggle.bind(this)}
          resetForm={this.resetForm.bind(this)}
        />
      </FormContainer>
      <ArchiveModal
        archiveItem='Staff member'
        archiveText='This action will remove this staff member, they will no longer be able to access their account. Are you sure you want to do this?'
        isOpen={this.state.archiveModal}
        toggle={this.toggle.bind(this)}
        onSubmit={this.onArchiveStaffMember.bind(this)}
      />
      </div>
    )
  }
}

function mapStateToProps(state){
  return {
    branches: state.branchReducer.branches,
    roles: state.roleReducer.roles,
    units: state.businessUnitReducer.businessUnits,
    userType: state.staffReducer.userType
  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(StaffForm)
