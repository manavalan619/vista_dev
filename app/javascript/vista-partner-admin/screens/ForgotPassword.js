import React, { Component } from 'react'
import axios from 'axios'
import { Button, Form, FormGroup, Input, Container } from 'reactstrap'
import serialize from 'form-serialize'
import logo from '../images/logo.png'
import '../styles.css'
import { emailCheck } from '../validation/validation'
// const style = {
//   input: {
//     border:'1px solid #B1933B'
//   }
// }

export default class ForgotPassword extends Component {
  constructor(props){
    super(props)
    this.state = {
      validationErrors: []
    }
  }


  onSubmit(evt){
    evt.preventDefault()
    let formData = serialize(evt.target, { hash: true })
    const result = emailCheck(evt.target.elements)
    if (result.length){
      this.setState({ validationErrors: result})
    } else {
      // replace with route for forgotten passwords
      axios.post(`/password/reset`, formData )
      .then(resp => {
        this.props.history.push('/login')
      })
      .catch((response)=>{
        this.setState({validationErrors: [{email:'No email matching the one given was found'}]})
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
              <span style={{textAlign:'center'}}>Enter your email address and hit submit to get an email with instructions on how to reset your password</span>
              <FormGroup>

              <Input style={{marginBottom: '6px'}} className='login-input' name='email' type='text' placeholder='Email' defaultValue='a@a.com' placeholder='Email'/>
              { this.renderErrors('email')}
              <Input className='login-input login-btn' type='submit' />
              </FormGroup>

            </Form>
          </div>
        </Container>
      </div>
    )
  }
}
