import React, { Component } from 'react'
import { Button, Modal, ModalBody, ModalHeader, ModalFooter, Form } from 'reactstrap'
import axios from 'axios'
import serialize from 'form-serialize'
import { branchForm } from '../validation/validation'
import FormContainer from '../components/FormContainer'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'
import ArchiveModal from '../components/ArchiveModal'
import FormButtons from '../components/FormButtons'
import Promise from 'bluebird'

const fields = [
  {
    name: 'name',
    type: 'text',
    label: 'Branch name'
  }, {
    name: 'address',
    type: 'text',
    label: 'Branch address'
  }, {
    name: 'telephone',
    type: 'text',
    label: 'Phone number'
  }, {
    name: 'email',
    type: 'text',
    label: 'Email'
  }, {
    type: 'text',
    name:'image',
    label: 'Image',
    placeholder: 'https://www.myimages/example.gif',

  }, {
    type: 'textarea',
    name:'branch_info',
    label: 'Branch info'
  }
]

class EditBranch extends Component {
  constructor(props) {
    super(props)
    this.state = {
      validationErrors: [],
      fields,
      archiveModal: false,
      ready: false
    }
  }

  toggle(modal) {
    this.setState({ archiveModal: !this.state.archiveModal })
  }

  componentDidMount() {
    const { match, actions } = this.props
    const { unitId, branchId } = match.params
    Promise.all([
      axios.get(`/units/${unitId}`),
      axios.get(`/units/${unitId}/branches/${branchId}`)
    ]).spread((unit, branch) => {

      this.props.updateBreadcrumbs([
        {
          path: `/units`,
          title: 'Business units'
        }, {
          path: `/units/${unit.data.id}`,
          title: unit.data.name
        }, {
          title: branch.data.name
        }
      ])
      fields.forEach((field) => {
        field.value = branch.data[field.name] || ''
      })
      this.setState({ fields, ready: true })
    })
  }

  onArchiveBranch = (evt) => {
    evt.preventDefault()
    const { unitId, branchId } = this.props.match.params

    axios.delete(`/units/${unitId}/branches/${branchId}`)
    .then(response => {
      this.props.actions.archiveBranch(branchId)
      this.props.history.push(`/units`)
      this.props.actions.pushFlashMessage({
        text: `Branch successfully archived.`,
        color: 'success'
      })
    }).catch(error => {
      this.props.actions.pushFlashMessage({
        text: `There was a problem archiving the branch.`,
        color: 'danger'
      })
    })
  }

  onSubmit(evt){
    evt.preventDefault()
    const { actions, history, match } = this.props
    const { unitId, branchId } = match.params
    const formData = serialize(evt.target, { hash: true })
    let result = branchForm(evt.target.elements)
    if (result.length){
      this.setState({ validationErrors: result})
    } else {
      axios.put(`/units/${unitId}/branches/${branchId}`, { branch: formData })
      .then( ({data}) => {
        this.props.actions.updateBranchList(data)
        history.goBack()
        this.props.actions.pushFlashMessage({
          text:`Branch successfully edited.`,
          color: 'success'
        })
      })
      .catch(err => {
        this.props.actions.pushFlashMessage({
          text:`There was a problem editing the branch.`,
          color: 'danger'
        })
      })
    }
  }

  render(){
    if(!this.state.ready) return null
    return (
      <div>
        <FormContainer
          formTitle='Edit branch'
          fields={this.state.fields}
          onSubmit={this.onSubmit.bind(this)}
          validationErrors={this.state.validationErrors}
        >
          <FormButtons
            userType={this.props.userType}
            isEditing={true}
            onArchive={this.toggle.bind(this)}
            resetForm={this.props.history.goBack}
          />
        </FormContainer>
       <ArchiveModal
         archiveItem='branch'
         archiveText='This action will also archive all staff associated with this branch. Are you sure you want to do this?'
         isOpen={this.state.archiveModal}
         toggle={this.toggle.bind(this)}
         onSubmit={this.onArchiveBranch.bind(this)}
       />
      </div>
    )
  }
}

function mapStateToProps(state){
  return {
    businessUnit: state.businessUnitReducer.businessUnit,
    branches: state.branchReducer.branches,
    userType: state.staffReducer.userType
  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(EditBranch)
