import React, { Component } from 'react'
import { Container, Button, Badge, Card } from 'reactstrap'
import ComponentList from '../components/ComponentList'
import FormModal from '../components/FormModal'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'
import axios from 'axios'
import serialize from 'form-serialize'
import TableSection from '../components/TableSection'
import FlashMessage from '../components/FlashMessage'
import { units, roles } from '../field-control'
import IconEdit from 'react-icons/lib/fa/edit'
import Promise from 'bluebird'


const styles = {
  extraFieldsContainer: {
    display: 'flex',
    justifyContent: 'flex-end',
    alignItems: 'center',
    // textDecoration:'none'
  },
  icons: {
    marginLeft: '5px',
    marginRight: '5px'
  },
  tableButton:{
    // textDecoration: 'underline',
    fontSize: '0.7em',
  },
  suspendButton:{
    minWidth: '75px'
  },
  addButton: {
    margin: '5px'
  }
}

class RolesIndex extends Component {
  componentWillMount() {
    axios.get(`/roles`).then(roles => {
      this.props.actions.fillRoleList(roles.data)
    })
  }

  onClickRoleRow = (item, event) => {
    this.props.history.push(`/roles/${item.id}/edit`)
  }

  extraRolesFields(item) {
    const { history } = this.props
    return [{
      addedComponent: (
        <div style={styles.extraFieldsContainer}>
          <div className='edit-tooltip'>
            <IconEdit  style={styles.icons} onClick={() => history.push(`/roles/${item.id}/edit`)}/>
            <span className="edit-tooltiptext">Edit role</span>
          </div>

        </div>
      ),
      textForHeader: '',
      handler: () => { console.log('yo') }
    }]
  }

  render(){
    return(
      <Container fluid>
        <Card>
          <div className='header'>
            <div className='clearfix'>
              <h4 className='title float-left'>Roles</h4>
              <Button
                color='primary'
                className='float-right btn-fill'
                onClick={()=> {this.props.history.push(`/roles/new`)}}
              >+ Add role</Button>
            </div>
          </div>
          <div className='content'>
            <TableSection
              excludeFields={['password']}
              mapFieldsToHeader= {roles.mapFieldsToHeader}
              onClickRow={this.onClickRoleRow}
              items={this.props.roles}
            />
          </div>
        </Card>
      </Container>
    )
  }
}

function mapStateToProps(state) {
  return {
    businessUnits: state.businessUnitReducer.businessUnits,
    roles: state.roleReducer.roles
  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(RolesIndex)
