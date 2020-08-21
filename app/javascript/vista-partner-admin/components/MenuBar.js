import React, { Component } from 'react'
import bootstrap from  'bootstrap/dist/css/bootstrap.css'
import {Navbar, NavItem, Nav, NavLink, NavbarBrand, NavbarToggler, Collapse} from 'reactstrap'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'


class MenuBar extends Component {
  constructor(props) {
    super(props)
    this.state = {
      isOpen: false
    }

    this.organisationName = this.organisationName.bind(this)
    this.renderBusinessUnitsLink = this.renderBusinessUnitsLink.bind(this)
  }

  toggle = () => {
    this.setState({
      isOpen: !this.state.isOpen
    })
  }

  onLogOut(){
    localStorage.removeItem("token")
    localStorage.removeItem("organisation")
    localStorage.removeItem("userType")
    this.props.actions.logoutUser()
  }

  organisationName () {
    return this.props.organisation || "Vista admin"
  }

  renderBusinessUnitsLink () {
    if (this.props.userType != 'Admin') { return; }

    return (
      <NavLink tag={Link} to='/units' >
        Business Units
      </NavLink>
    )
  }

  render() {
    if (!this.props.userToken) { return null }

    return (
      <Navbar light toggleable className='navbar-fixed navbar-white pt-0 pb-0'>
        <NavbarToggler right onClick={this.toggle} />
        <NavbarBrand href="/">{this.organisationName()}</NavbarBrand>
        <Collapse isOpen={this.state.isOpen} navbar>
          <Nav className="ml-auto" navbar>
            {/* <NavItem>
              { this.renderBusinessUnitsLink() }
            </NavItem>
            <NavItem>
              <NavLink tag={Link} to='/roles'>
                Roles
              </NavLink>
            </NavItem>
            <NavItem>
              <NavLink tag={Link} to='/staff'>
                Staff members
              </NavLink>
            </NavItem> */}
            <NavItem>
              <NavLink tag={Link} to='/login' onClick={this.onLogOut.bind(this)} >
                Log out
              </NavLink>
            </NavItem>
          </Nav>
        </Collapse>
      </Navbar>
    )
  }
}

function mapStateToProps(state){
  return {
    userToken: state.staffReducer.userToken,
    organisation: state.staffReducer.organisation,
    userType: state.staffReducer.userType
  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(MenuBar)
