import React, { Component } from 'react'
import { Container, Button, Card } from 'reactstrap'
import TableSection from '../components/TableSection'
import FormModal from '../components/FormModal'
import EmptyState from '../components/EmptyState'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'
import { Link } from 'react-router-dom'
import axios from 'axios'
import Promise from 'bluebird'
import { branches } from '../field-control'
import serialize from 'form-serialize'
import { branchForm } from '../validation/validation'

class UnitsShow extends Component {
  constructor(props) {
    super(props)
    this.state = {
      modalVisible: false,
      validationErrors: []
    }
  }

  toggle = () => {
    const { modalVisible } = this.state
    if (modalVisible) {
      this.setState({
        modalVisible: false,
        validationErrors: []
      })
    }
    this.setState({
      modalVisible: !this.state.modalVisible,
      input: ''
    })
  }

  componentWillMount() {
    const { match: { params: { unitId } } } = this.props
    Promise.all([
      axios.get(`/units/${unitId}`),
      axios.get(`/units/${unitId}/branches`)
    ]).spread((unit, branches) => {
      this.props.actions.viewUnit(unit.data)
      this.props.actions.fillBranchList(branches.data)
    })
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.businessUnit) {
      this.props.updateBreadcrumbs([
        {
          path: `/units`,
          title: 'Business units'
        }, {
          path: `/units/${nextProps.businessUnit.id}`,
          title: nextProps.businessUnit.name
        }
      ])
    }
  }

  showFlashMessage(companyLevel, success) {
    let text = success ? `${companyLevel} successfully added.` : `There was a problem adding the ${companyLevel}`
    this.props.actions.pushFlashMessage({
      text,
      color: success ? 'success' : 'danger'
    })
  }

  onClickAddBranch = (evt) => {
    evt.preventDefault()
    let formData = serialize(evt.target, { hash: true })
    let result = branchForm(evt.target.elements)
    if (result !== true) {
      return this.setState({ validationErrors: result })
    }
    axios.post(`/units/${this.props.businessUnit.id}/branches`,{
      branch: formData
    })
    .then(response => {
      this.props.actions.addBranch(response.data)
      this.toggle()
      this.showFlashMessage('Branch', true)
    })
    .catch( err =>{
      this.showFlashMessage('Branch', false)
    })
  }

  onClickRow = (item) => {
    const { history, match: { params: { unitId } } } = this.props
    history.push(`/units/${unitId}/branches/${item.id}/edit`)
  }

  render() {
    const { businessUnit = {}, match: { params: { unitId } } } = this.props

    return (
      <Container fluid>
        <Card>
          <div className='header'>
            <div className='clearfix'>
              <h4 className='title float-left'>{businessUnit.name}</h4>
              <div className='button-container'>
                <Button color='secondary' className='float-right btn-fill' onClick={() => this.props.history.push('/units')}>
                  Back
                </Button>
                <Button tag={Link} to={`/units/${unitId}/edit`} color='primary' className='float-right btn-fill'>
                  Edit unit
                </Button>
                <Button color='primary' className='float-right btn-fill' onClick={this.toggle}>
                  + Add branch
                </Button>
              </div>
            </div>
          </div>

          <div className='content'>
            <h5 className='title'>Branches</h5>

            {this.props.branches.length ?
              <TableSection
                mapFieldsToHeader={branches.mapFieldsToHeader}
                onClickRow={(item) => this.onClickRow(item)}
                items={this.props.branches}
              />
              : <EmptyState message='No branches' />
            }
            <FormModal
              modalType='branch'
              validationErrors={this.state.validationErrors}
              onAdd={this.onClickAddBranch}
              unitFieldCtrl={branches}
              isOpen={this.state.modalVisible}
              toggle={this.toggle}
            />
          </div>
        </Card>
      </Container>
    )
  }
}

function mapStateToProps(state){
  return {
    businessUnit: state.businessUnitReducer.businessUnit,
    branches: state.branchReducer.branches
  }
}

function mapDispatchToProps(dispatch){
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(UnitsShow)
