import React, { Component } from 'react'
import { Container, Button, Card } from 'reactstrap'
import FormModal from '../components/FormModal'
import TableSection from '../components/TableSection'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'
import axios from 'axios'
import { units } from '../field-control'
import serialize from 'form-serialize'
import { unitForm } from '../validation/validation'



class UnitsPage extends Component {
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
    this.props.updateBreadcrumbs([{ path: '/units', title: 'Business units' }])
    axios.get('/units')
    .then(response => this.props.actions.fillUnitList(response.data))
  }

  onClickAddUnit = (evt) => {
    evt.preventDefault()
    let formData = serialize(evt.target, { hash: true })
    let result = unitForm(evt.target.elements)
    if (result !== true) {
      return this.setState({ validationErrors: result })
    }
    axios.post('/units', {
      business_unit: formData
    })
    .then(response => {
      this.props.actions.addUnit(response.data)
      this.toggle()
      this.showFlashMessage('Unit', true)
    })
    .catch(() => {
      this.showFlashMessage('Unit', false)
    })

  }

  showFlashMessage(companyLevel, success){
    let text = success ? `${companyLevel} successfully added.` : `There was a problem adding the ${companyLevel}`
    this.props.actions.pushFlashMessage({
      text,
      color: success ? 'success' : 'danger'
    })
  }

  onClickRow = (item) => {
    this.props.actions.viewUnit(item)
    this.props.history.push(`/units/${item.id}`)
  }

  render() {

    return (
      <Container fluid>
        <Card>
          <div className='header'>
            <div className='clearfix'>
              <h4 className='title float-left'>Business Units</h4>
              <Button color='primary' className='float-right btn-fill' onClick={this.toggle}>
                + Add unit
              </Button>
            </div>
          </div>


          <div className='content'>
            <TableSection
              mapFieldsToHeader={units.mapFieldsToHeader}
              onClickRow={(item) => this.onClickRow(item)}
              items={this.props.businessUnits}
            />

            <FormModal
              validationErrors={this.state.validationErrors}
              modalType='business unit'
              onAdd={this.onClickAddUnit}
              unitFieldCtrl={units}
              isOpen={this.state.modalVisible}
              toggle={this.toggle}
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
  }
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(actions, dispatch)
  }
}

export default connect(mapStateToProps,mapDispatchToProps)(UnitsPage)
