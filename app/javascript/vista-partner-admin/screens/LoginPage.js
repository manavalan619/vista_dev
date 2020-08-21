import React, { Component } from 'react'
import axios from 'axios'
import { Button, Form, FormGroup, Input, Container} from 'reactstrap'
import { Link } from 'react-router-dom'
import serialize from 'form-serialize'
import logo from '../images/logo.png'
import '../styles.css'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'

class Login extends Component {

  constructor(props){
    super(props)
    this.state = { error: false}
  }

  onSubmit(evt){
    evt.preventDefault()
    let formData = serialize(evt.target, { hash: true })
    axios.post(`/staff/login`, formData )
    .then(resp => {
      axios.defaults.headers.common['Authorization'] = `Token token=${resp.data.token}`
      this.props.actions.setUser(resp.data.token)
      this.props.actions.setOrganisation(resp.data.organisation)
      this.props.actions.setUserType(resp.data.user_type)
      localStorage.setItem('token', resp.data.token)
      localStorage.setItem('organisation', resp.data.organisation)
      localStorage.setItem('userType', resp.data.user_type)

      // TODO: if somehow userType == 'StaffMember', then
      // we need to logout the user, if not already handled on api side
      if (resp.data.user_type == 'Admin') {
        this.props.history.push('/units')
      } else {
        this.props.history.push('/roles')
      }
    })
    .catch(err => {
      this.setState({error: true})
    })
  }

  renderError(){
    if (this.state.error){
      return <span
        className="float-right login-link-text"
        style={{color: 'red', marginBottom:'3px'}}>
          Incorrect password/email
        </span>
    }
    return null
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
              <Input style={{marginBottom: '6px'}} className='login-input' name='email' type='text' placeholder='Email' defaultValue='a@a.com' placeholder='Email'/>
              <Input style={{marginBottom: '6px'}} className='login-input' name='password' type='password' placeholder='Password' defaultValue='Password123' placeholder='Password' />
              { this.renderError() }
              <Input style={{marginBottom: '6px'}} className='login-input login-btn' type='submit' />
              <Link to="/password/reset"><span className="float-right login-link-text" >Forgot password?</span></Link>
            </Form>
          </div>
        </Container>
      </div>
    )
  }
}


function mapStateToProps(state) {
  return {
    userToken: state.staffReducer.userToken,
  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(Login)
