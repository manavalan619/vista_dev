import React, { Component } from 'react'
import { Button, Input, Card, CardTitle, Label, Container, Form, FormGroup } from 'reactstrap'
import serialize from 'form-serialize'
import { passwordForm } from '../validation/validation'

export default class ChangePassword extends Component {
  constructor(props){
    super(props)
    this.state = {
      validationErrors: [],
      ready: false
    }
  }

  onSubmit(evt){
    evt.preventDefault()
    const formData = serialize(evt.target)
    let result = passwordForm(evt.target.elements)
    if (result.length){
      this.setState({ validationErrors: result})
    } else {
      axios.post(`/user`, formData)
      .then(({data})=>{
        console.log(data)
      })
    }
  }

  renderErrors(field){
    if (!this.state.validationErrors.length) return null
    let error = this.state.validationErrors.find(error => {
      return error.hasOwnProperty(field)
    })
    if (error) return (
      <small
        style={{color: 'red', marginBottom:'3px'}}
        className='float-right'
      >{error[field]}
      </small>
    )
  }

  render(){
    return(
      <Container>
      <Card style={{padding:'20px'}}>
        <CardTitle>Change Password</CardTitle>
        <Form onSubmit={this.onSubmit.bind(this)}>
          <FormGroup>
            <Label>
              Current Password:
            </Label>
            <Input type="password" />
          </FormGroup>
          <FormGroup>
            <Label>
              New password:
            </Label>
            <Input type="password" name="password"/>
            { this.renderErrors('password')}

          </FormGroup>
          <FormGroup>
            <Label>
              Retype new password:
            </Label>
            <Input type="password" name="password_confirmation"/>
            { this.renderErrors('password_confirmation')}
          </FormGroup>
          <div style={{display: 'flex', justifyContent:'space-around', width: '180px'}}>
            <Button color="primary" type='submit'>Save</Button>
            <Button color="secondary" onClick={this.props.history.goBack}>Cancel</Button>
          </div>
        </Form>

      </Card>
      </Container>
    )
  }
}
