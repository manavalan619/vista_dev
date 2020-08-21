import React, { Component } from 'react'
import bootstrap from  'bootstrap/dist/css/bootstrap.css'
import {Navbar, NavItem, Nav, NavLink, NavbarBrand, NavbarToggler, Collapse} from 'reactstrap'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'

class SideBar extends Component {
  constructor(props) {
    super(props)
    this.state = {
      isOpen: false
    }

    this.organisationName = this.organisationName.bind(this)
    this.renderBusinessUnitsLink = this.renderBusinessUnitsLink.bind(this)
  }

  organisationName () {
    return this.props.organisation || "Vista admin"
  }

  renderBusinessUnitsLink () {
    if (this.props.userType != 'Admin') { return; }

    return (
      <NavLink tag={Link} to='/units'>
        Business Units
      </NavLink>
    )
  }

  render() {
    if (!this.props.userToken) { return null }

    return (
      <div className='sidebar has-image' data-color='black'>
        <div className='sidebar-wrapper'>
          <div className="logo">
            <Link to='/' className="simple-text">Vista</Link>
          </div>
          <Nav vertical>
            <NavItem>
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
            </NavItem>
          </Nav>
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    userToken: state.staffReducer.userToken,
    organisation: state.staffReducer.organisation,
    userType: state.staffReducer.userType
  }
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(SideBar)
