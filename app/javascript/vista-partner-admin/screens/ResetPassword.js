import React, { Component } from 'react'
import axios from 'axios'
import { Button, Form, FormGroup, Input, Container } from 'reactstrap'
import serialize from 'form-serialize'
import logo from '../images/logo.png'
import '../styles.css'
import { passwordForm } from '../validation/validation'
// const style = {
//   input: {
//     border:'1px solid #B1933B'
//   }
// }

export default class ResetPassword extends Component {
  constructor(props){
    super(props)
    this.state = {
      validationErrors: []
    }
  }

  onSubmit(evt){
    evt.preventDefault()
    const formData = serialize(evt.target, { hash: true })
    const result = passwordForm(evt.target.elements)
    if (result.length){
      this.setState({ validationErrors: result})
    } else {
      // replace with route for forgotten passwords
      const { token } = this.props.match.params
      formData.token = token
      axios.put(`/password/reset`, formData )
      .then(resp => {
        this.props.history.push('/login')
      })
      .catch(err => console.log(err))
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
  render() {
    return (
      <div className='without-sidenav'>
        <Container
          style={{
            display: 'flex',
            justifyContent:'center',
            alignItems:'center',
            flexDirection: 'column',

          }}
        >
          <div style={{width:'50%'}} >
            <img src={logo} alt='vista logo' style={{maxWidth:'100%'}}/>
            <Form onSubmit={this.onSubmit.bind(this)} style={{
              // display:'flex',
              // flexDirection: 'column',
              // flex:1,
              // justifyContent: 'space-between',
              // minHeight:'150px'
            }}>
              <FormGroup>

                <Input style={{marginBottom: '6px'}} type="password" name="password" placeholder="Enter new password here"/>
                { this.renderErrors('password')}
              </FormGroup>
              <FormGroup>
                <Input style={{marginBottom: '6px'}} type="password" name="password_confirmation" placeholder="Retype password here"/>
                { this.renderErrors('password_confirmation')}
              </FormGroup>
              <Input className='login-input login-btn' type='submit' />
            </Form>
          </div>
        </Container>
      </div>
    )
  }
}
