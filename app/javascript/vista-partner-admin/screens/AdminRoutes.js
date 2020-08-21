import React, { Component } from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'
import { Switch, Route } from 'react-router-dom'
import { BrowserRouter as Router} from 'react-router-dom'
import {
  requireAuth,
  UnitsPage,
  UnitShow,
  EditUnit,
  CreateBranch,
  EditBranch
} from './'



class AdminRoutes extends Component {
  render(){
    if (this.props.userType !== 'Admin') return null
    return(
      <Router>
        <Switch>
          <Route exact path='/' component={requireAuth(UnitsPage)} />
          <Route exact path='/units' component={requireAuth(UnitsPage)} />
          <Route exact path='/units/:unitId' component={requireAuth(UnitShow)} />
          <Route exact path='/units/:unitId/edit' component={requireAuth(EditUnit)} />
          <Route exact path='/units/:unitId/branches/new' component={requireAuth(CreateBranch)} />
          <Route exact path='/units/:unitId/branches/:branchId/edit' component={requireAuth(EditBranch)} />
        </Switch>
      </Router>
    )
  }
}


const mapStateToProps = (state) => {
  return {
    userType: state.staffReducer.userType,
  }
}

// console.log('Routes', AdminRoutes)
export default connect(mapStateToProps)(AdminRoutes)