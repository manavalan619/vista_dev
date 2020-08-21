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
import { units, staffMembers, roles } from '../field-control'
import IconEdit from 'react-icons/lib/fa/edit'
import Promise from 'bluebird'

const styles = {
  extraFieldsContainer: {
    display: 'flex',
    flexDirection:'column',
    justifyContent: 'space-around',
    alignItems: 'centre',
    height:'50px'
  },
  icons: {
    marginLeft: '5px',
    marginRight: '5px'
  },
  tableButton:{
    fontSize: '0.7em',
  },
  suspendButton:{
    minWidth: '75px'
  },
  addButton: {
    margin: '5px'
  }
}

class StaffIndex extends Component {
  componentDidMount() {
    axios.get(`/staff`).then(staffMembers => {
      staffMembers && this.props.actions.fillStaffList(staffMembers.data)
    })
  }

  onClickStaffRow = (item, event) => {
    if(this.props.userType !== 'Admin' && item && item.type !== 'StaffMember') {
      this.props.actions.pushFlashMessage({
        text: `You do not have permission to edit this user.`,
        color: 'warning'
      })
    }else{
      this.props.history.push(`/staff/${item.id}/edit`)

    }
  }

  // Only allow Admin to suspend branch manager accounts
  renderSuspendButtons(item){
    const { icons, tableButton, addButton, extraFieldsContainer, suspendButton } = styles
    // if (this.props.userType !== 'Admin' && item && item.type !== 'StaffMember') return null
    return (
      item && item.suspended_at ?
        <Button
          size='sm'
          style={{ ...tableButton, ...icons, ...suspendButton }}
          onClick={(event) => {
            event.stopPropagation()
            this.onSuspendToggle('unsuspend', item)
          }}
        >Unsuspend</Button>
      : <Button
          size='sm'
          style={{...tableButton,...icons, ...suspendButton }}
          onClick={(event) => {
            event.stopPropagation()
            this.onSuspendToggle('suspend', item)
          }}
        >Suspend</Button>
      )
  }

  renderRowButtons(staff){
    const { userType } = this.props
    if (userType !== 'Admin' && staff && staff.type !== 'StaffMember') return null
    const { icons, tableButton, addButton, extraFieldsContainer, suspendButton } = styles
    return (
      <div style={ extraFieldsContainer }>
        { staff && !staff.confirmed_at && userType === 'Admin' &&
          <Button
            size='sm'
            style={{ ...tableButton, ...icons }}
            onClick={this.onInviteStaffMember.bind(this, staff)
          }>Invite</Button>
        }
        {this.renderSuspendButtons.call(this,staff)
        }
      </div>

    )
  }

  extraStaffFields(item) {
    const { icons, tableButton, addButton, extraFieldsContainer, suspendButton } = styles
    const { history } = this.props
    return [{
      addedComponent: (
        this.renderRowButtons.call(this,item)
      ),
      textForHeader: '',
      handler: () => { console.log('Handler') }
    }]
  }

  onInviteStaffMember(item, event) {
    event.stopPropagation()
    axios.put(`/staff/${item.id}/invite`).then(() => {
      this.props.actions.pushFlashMessage({
        text: `Invitation sent to ${item.first_name} ${item.last_name}.`,
        color: 'success'
      })
    }).catch(error => {
      this.props.actions.pushFlashMessage({
        text: `Could not invite ${item.first_name} ${item.last_name}.`,
        color: 'danger'
      })
    })
  }

  onSuspendToggle = (action, item) => {
    axios.put(`/staff/${item.id}/${action}`).then((response) => {
      // TODO: implement some form of flash notice
      this.props.actions[`${action}StaffMember`](response.data)
      this.props.actions.pushFlashMessage({
        text: `${item.first_name}'s account has been ${action}ed.`,
        color: 'success'
      })
    })
    .catch(err => {
      this.props.actions.pushFlashMessage({
        text: `There was a problem ${action}ing ${item.first_name} ${item.last_name}.`,
        color: 'danger'
      })
    })
  }

  renderBranchTitle(){
    if (this.props.userType === 'BranchManager' && this.props.staffMembers.length){
      return `(${this.props.staffMembers[0].branch})`
    }
  }

  render(){
    return(
      <Container fluid>
        <Card>
          <div className='header'>
            <div className='clearfix'>
              <h4 className='title float-left'>Staff members {this.renderBranchTitle.call(this)}</h4>
              <Button
                color='primary'
                className='float-right btn-fill'
                onClick={() => this.props.history.push(`/staff/new`)}
              >+ Add staff member</Button>
            </div>
          </div>
          <div className='content'>
            <TableSection
              excludeFields={ this.props.userType === 'Admin' ? ['roles'] : ['branch']}
              extraFields={this.extraStaffFields.bind(this)}
              mapFieldsToHeader={staffMembers.mapFieldsToHeader}
              onClickRow={this.onClickStaffRow}
              items={this.props.staffMembers}
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
    staffMembers: state.staffReducer.staffMembers,
    userType: state.staffReducer.userType
  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(StaffIndex)
