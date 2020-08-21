import React, { Component } from 'react'
import { Button, Form, FormGroup, Label, Input, Container, Card } from 'reactstrap'
import axios from 'axios'
import serialize from 'form-serialize'
import { branchForm } from '../validation/validation'
import FormContainer from '../components/FormContainer'
import { roleForm } from '../validation/validation'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'
import Promise from 'bluebird'
import FormButtons from '../components/FormButtons'
import ArchiveModal from '../components/ArchiveModal'

const fields = [
  {
    name: 'name',
    type: 'text',
    label: 'Branch role'
  }
]

class CreateBranchRole extends Component {
  constructor(props){
    super(props)
    Promise.promisifyAll(this)
    this.state = {
      validationErrors: [],
      dataLoaded: false,
      isEditing: false,
      archiveModal: false,
      fields
    }
  }

  toggle = (evt) => {
    evt.preventDefault()
    this.setState({ archiveModal: !this.state.archiveModal })
  }

  componentWillMount() {
    const { url, params } = this.props.match
    if (!this.props.roles.length) {
      axios.get(`/roles`).then(roles => {
        this.props.actions.fillRoleList(roles.data)
      })
    }
    this.setStateAsync({
      isEditing: url.split('/').slice(-1)[0] === 'edit'
    }).then(() => {
      return Promise.resolve(
        this.state.isEditing ? axios.get(`/roles/${params.roleId}`) : null
      )
    }).then(role => {
      if (this.state.isEditing) {
        fields.forEach(field => {
          field.value = role.data[field.name] || ''
        })
        this.props.actions.viewRole(role.data)
      }
      this.setState({ fields, dataLoaded: true })
    })
    .catch(err => console.log(err))
  }

  onSubmit(evt) {
    evt.preventDefault()
    const formData = serialize(evt.target, { hash: true })
    const result = roleForm(evt.target.elements)
    if (result.length) {
      this.setState({ validationErrors: result })
    } else {
      (
        this.state.isEditing ?
        axios.put(`/roles/${this.props.match.params.roleId}`, { role: formData }) :
        axios.post(`/roles`, { role: formData } )
      )
      .then(({data})=>{
        console.log(data)
        this.props.actions.pushFlashMessage({
          text:`Role successfully ${this.state.isEditing ? 'edited' : 'added'}.`,
          color: 'success'
        })
        this.resetForm.call(this)

      })
      .catch(err => {
        this.props.actions.pushFlashMessage({
          text:`There was a problem ${this.state.isEditing ? 'editing' : 'adding'} the role.`,
          color: 'danger'
        })
      })
    }
  }

  resetForm() {
    fields.forEach( field => { field.value = '' })
    this.setState({ isEditing: false, fields })
    this.props.history.push('/roles')
  }

  onArchiveRole = (evt) => {
    evt.preventDefault()
    const formData = serialize(evt.target, { hash: true })
    const { match: { params: { roleId } }, actions, history } = this.props
    console.log('history', history)
    axios.delete(`/roles/${roleId}?replace_with=${formData.newrole}`).then(() => {
      this.setState({ archiveModal: false })
      setTimeout(function () {
        history.push('/roles')
        actions.archiveRole(roleId)
        actions.pushFlashMessage({
          text: `Role archived successfully.`,
          color: 'success'
        })
      }, 0)
    }).catch(error => {
      actions.pushFlashMessage({
        text: `Role archived successfully.`,
        color: 'success'
      })
    })
  }

  renderOptions() {
    return this.props.roles.reduce((memo, role) => {
      if (role.id !== parseInt(this.props.match.params.roleId, 10)) {
        memo.push(<option value={role.id} key={role.id}>{role.name}</option>)
      }
      return memo
    }, [])
  }

  render(){
    if(!this.state.dataLoaded) return null
    return (
      <div>
        <FormContainer
          formTitle={this.state.isEditing ? 'Edit role' : 'Create role'}
          fields={this.state.fields}
          onSubmit={this.onSubmit.bind(this)}
          validationErrors={this.state.validationErrors}
        >
          <FormButtons
            userType={this.props.userType}
            isEditing={this.state.isEditing}
            onArchive={this.toggle}
            resetForm={this.resetForm.bind(this)}
          />
        </FormContainer>
        <ArchiveModal
          archiveItem='role'
          archiveText={`This action will remove this role and assign a new role to all staff with this role. Are you sure you want to do this?`}
          isOpen={this.state.archiveModal}
          toggle={this.toggle}
          onSubmit={this.onArchiveRole}
        >
          <br/>
          <FormGroup style={{marginTop: '5px', fontWeight:'bold'}}>
          <Label>Pick the replacement role for the staff:</Label>
            <Input type='select' name='newrole'>
              { this.renderOptions()}
            </Input>
          </FormGroup>
        </ArchiveModal>
      </div>
    )
  }
}


function mapStateToProps(state){
  return {
    businessUnits: state.businessUnitReducer.businessUnits,
    unitTab: state.businessUnitReducer.unitTab,
    branches: state.branchReducer.branches,
    roles: state.roleReducer.roles,
    userType: state.staffReducer.userType
  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(CreateBranchRole)
