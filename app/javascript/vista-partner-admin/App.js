import 'bootstrap/dist/css/bootstrap.css';
import './styles.css'
import './styles/dashboard.scss'
import 'react-select/dist/react-select.css'
import React from 'react'
import { Container } from 'reactstrap'
import { Switch, Route } from 'react-router-dom'
import MenuBar from './components/MenuBar'
import SideBar from './components/SideBar'
import { BrowserRouter as Router} from 'react-router-dom'
import { Provider } from 'react-redux'
import FlashMessage from './components/FlashMessage'

import {
  AdminRoutes,
  HomePage,
  UnitsPage,
  LoginPage,
  CreateBranch,
  requireAuth,
  StaffForm,
  RoleForm,
  CreateBranchRole,
  StaffIndex,
  EditUnit,
  EditBranch,
  ForgotPassword,
  ResetPassword,
  ConfirmAccount,
  RolesIndex,
  UnitShow
} from './screens'
import ChangePassword from './components/ChangePassword'
import devToolsEnhancer from 'remote-redux-devtools'
import { createStore } from 'redux'
import reducer from './reducers'
import axios from 'axios'
const store = createStore(reducer, devToolsEnhancer())

export default class App extends React.Component {
  componentWillMount() {
    // axios.defaults.baseURL = '/api/admin'
    axios.defaults.baseURL = 'http://api.vista.test/admin'
    axios.defaults.headers.common['Authorization'] = `Token token=${localStorage.getItem("token")}`
  }

  render() {
    // TODO: only allow access to password resetting / login, if not logged in
    return (
      <Provider store={store}>
        <Router>

          <div className='wrapper'>
            <SideBar />
            <div className='main-panel'>
              <MenuBar />
              <div className='content'>
                <Switch >
                  <Route exact path='/login' component={LoginPage} />
                  <Route exact path='/staff' component={requireAuth(StaffIndex)} />
                  <Route exact path='/staff/new' component={requireAuth(StaffForm)} />
                  <Route exact path='/staff/:staffId/edit' component={requireAuth(StaffForm)} />
                  <Route exact path='/roles' component={requireAuth(RolesIndex)}/>
                  <Route exact path='/roles/new' component={requireAuth(RoleForm)}/>
                  <Route exact path='/roles/:roleId/edit' component={requireAuth(RoleForm)} />
                  <Route exact path='/branch' component={requireAuth(CreateBranch)} />
                  <Route exact path='/password/reset' component={ForgotPassword} />
                  <Route exact path='/password/new/:token' component={ResetPassword} />
                  <Route exact path='/account/confirmation/:token' component={ConfirmAccount} />
                  <AdminRoutes />
                </Switch>
                <FlashMessage />
              </div>
            </div>
          </div>
        </Router>
      </Provider>
    )
  }
}
