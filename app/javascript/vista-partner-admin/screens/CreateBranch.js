import React, { Component } from 'react'
import {
  Button,
  Form,
  FormGroup,
  Label,
  Input,
  Container,
  Card
} from 'reactstrap'
import axios from 'axios'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'
import serialize from 'form-serialize'

class CreateBranch extends Component {

  // componentWillMount(){
  //   // TODO - change request to get ALL branches belonging to organisation
  //   axios.get(`/units/10/branches`)
  //   .then(({data}) => {
  //     this.props.actions.fillBranchList(data)
  //   })
  //   .catch(err => console.log(err))
  // }

  onSubmit(evt){
    evt.preventDefault()
    let formData = serialize(evt.target,{ hash: true })
    axios.post(`/units/${this.props.unitInFocus.id}/branches`, {
      branch: formData
    })
    .then(()=>{
      this.props.actions.pushFlashMessage({
        text:`Branch successfully edited.`,
        color: 'success'
      })
    })
    .catch(()=>{
      this.props.actions.pushFlashMessage({
        text:`There was a problem editing the branch.`,
        color: 'danger'
      })
    })
    console.log('hello you have submitted the form')
  }

  render(){
    return (
      <Container>
      <Card>
        <Form onSubmit={this.onSubmit.bind(this)} >
          <h1>Create Branch</h1>
          <FormGroup>
            <Label for='name'>Branch name</Label>
            <Input
              autoComplete='off'
              type='text'
              name='name'
              id='name'
            />
          </FormGroup>
          <FormGroup>
            <Label for='address'>Branch Address</Label>
            <Input
              autoComplete='off'
              type='text'
              name='address'
              id='address'
            />
          </FormGroup>
          <FormGroup>
            <Label for='telephone'>Telephone</Label>
            <Input
              autoComplete='off'
              type='text'
              name='telephone'
              id='telephone'
            />
          </FormGroup>
          <FormGroup>
            <Label for='email'>Email</Label>
            <Input
              autoComplete='off'
              type='email'
              name='email'
              id='email'
            />
          </FormGroup>
          <Button color="primary" type='submit'>Add</Button>
          <Button color="secondary" onClick={this.props.history.goBack}>Cancel</Button>
          </Form>
        </Card>
      </Container>
    )
  }
}



function mapStateToProps(state){
  return {
    businessUnits: state.businessUnitReducer.businessUnits,
    unitTab: state.businessUnitReducer.unitTab,
    unitInFocus: state.businessUnitReducer.unitInFocus,
    branches: state.branchReducer.branches,
    branchInFocus: state.branchReducer.branchInFocus

  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(CreateBranch)
