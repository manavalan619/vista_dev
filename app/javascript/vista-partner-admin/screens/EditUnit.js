import React, { Component } from 'react'
import { Button } from 'reactstrap'
import axios from 'axios'
import serialize from 'form-serialize'
import { unitForm } from '../validation/validation'
import FormContainer from '../components/FormContainer'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'
import ArchiveModal from '../components/ArchiveModal'
import FormButtons from '../components/FormButtons'

const fields = [
  {
    name: 'name',
    type: 'text',
    label: 'Unit name'
  },
  {
    name: 'id',
    type: 'hidden'
  }
]

class EditBranch extends Component {
  constructor(props){
    super(props)
    this.state = {
      validationErrors: [],
      fields,
      ready: false,
      archiveModal: false
    }
  }

  toggle(modal){
    this.setState({ archiveModal: !this.state.archiveModal })
  }

  componentDidMount(){
    const { match, actions } = this.props
    axios.get(`/units/${match.params.unitId}/`)
    .then(({data}) => {
      fields.forEach((field)=>{
        if(data[field.name]){
          field.value = data[field.name]
        }
      })
      actions.viewUnit(data)
      this.setState({ fields, ready: true })
      this.props.updateBreadcrumbs([
        {
          path: `/units`,
          title: 'Business units'
        }, {
          path: `/units/${data.name}`,
          title: data.name
        }
      ])
    })

  }


  onArchiveUnit(evt) {
    evt.preventDefault()

    const { match, actions, history } = this.props
    const { unitId } = match.params

    axios.delete(`/units/${unitId}`).then(data => {
      actions.archiveUnit(unitId)
      history.push('/units')
      actions.pushFlashMessage({
        text:`Unit successfully archived.`,
        color: 'success'
      })
    })
  }

  onSubmit(evt){
    evt.preventDefault()
    const { match, history, actions } = this.props
    const formData = serialize(evt.target, { hash: true })
    let result = unitForm(evt.target.elements)
    if (result.length){
      this.setState({ validationErrors: result})
    } else {
      axios.put(`/units/${match.params.unitId}`, formData)
      .then(({data})=>{
        history.goBack()
        actions.pushFlashMessage({
          text:`Unit successfully edited.`,
          color: 'success'
        })
      })
      .catch(err => {
        actions.pushFlashMessage({
          text:`There was a problem editing the unit.`,
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
        formTitle='Edit unit'
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
        archiveItem='unit'
        archiveText='This action will also archive all branches and staff associated with this unit. Are you sure you want to do this?'
        isOpen={this.state.archiveModal}
        toggle={this.toggle.bind(this)}
        onSubmit={this.onArchiveUnit.bind(this)}
      />
      </div>
    )
  }
}

function mapStateToProps(state){
  return {
    branches: state.branchReducer.branches,
    fillBranchList: state.branchReducer.fillBranchList,
    openChevron: state.chevronReducer.openChevron,
    units: state.businessUnitReducer.unitInFocus,
    userType: state.staffReducer.userType

  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(EditBranch)
