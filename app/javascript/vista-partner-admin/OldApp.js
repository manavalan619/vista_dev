import PropTypes from 'prop-types';
import styles from './styles'
import React from 'react';
import bootstrap from  'bootstrap/dist/css/bootstrap.css';
import { Switch, Route } from 'react-router-dom'
import MenuBar from './components/MenuBar'
import HomePage from './screens/HomePage'
import UnitsPage from './screens/UnitsPage'
import UnitPage from './screens/UnitPage'
import BranchPage from './screens/BranchPage'
import Login from './components/Login'
import PartnerPage from './screens/PartnerPage'
import RolesPage from './screens/RolesPage'
// bootstrap colors
// primary, success, info, faded, warning, danger, inverse

import { BrowserRouter as Router} from 'react-router-dom'
import { Provider } from 'react-redux'
import devToolsEnhancer from 'remote-redux-devtools'
import { createStore } from 'redux'
import reducer from './reducers'
let store = createStore(reducer, devToolsEnhancer())

import axios from 'axios'
const token = document.getElementsByName('csrf-token')[0].getAttribute('content')
console.log(token)
axios.defaults.headers.common['X-CSRF-Token'] = token

export default class App extends React.Component {
  // static propTypes = {
  //   data: PropTypes.string.isRequired, // this is passed from the Rails view
  // };

  // constructor(props, _railsContext) {
  //    super(props);
  //    this.state = { data: this.props.name };
  //  }

  render(){
    return (
      <Provider store={store}>
        <Router>
          <div data={this.props.data}>
            <MenuBar />
            <Switch>
              <Route exact path='/' component={HomePage}/>
              <Route path='/login' component={Login} />
              <Route path='/units/:unitId/branches/:branchId/partners/:partnerId' component={PartnerPage}/>
              <Route path='/units/:unitId/partners/:partnerId' component={PartnerPage}/>
              <Route path='/units/:unitId/branches/:branchId' component={BranchPage} />
              <Route path='/login' component={Login} />
              <Route path='/units/:id' component={UnitPage}/>
              <Route path='/units' component={UnitsPage}/>
              <Route path='/roles' component={RolesPage}/>
            </Switch>
          </div>
        </Router>
      </Provider>
    )
  }
}
