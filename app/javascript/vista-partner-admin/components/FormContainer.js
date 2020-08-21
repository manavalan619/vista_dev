import React, { Component } from 'react'
import { Button, Form, FormGroup, Label, Input, Container, Card } from 'reactstrap'
import axios from 'axios'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as actions from '../actions/actionCreators'
import serialize from 'form-serialize'
import Select from 'react-select'

const renderOptions = (options) => {
  if (!options) return null
  return options.map(option => {
    return (
      <option
        key={option.value}
        value={option.value}
      >
        {option.text }
      </option>
    )
  })
}

const renderErrors = (props, field) => {
  if (!props.validationErrors.length) return null
  let error = props.validationErrors.find(error => {
    return error.hasOwnProperty(field)
  })
  if (error) return (
    <small
      style={{color: 'red'}}
      className='float-right'
    >{error[field]}
    </small>
  )
}

const renderBottomSection = (field) => {
  if (field.name === 'pin1'){
    return (
      <div>
        <hr/>
        <h4>Please choose a four digit pin:</h4>
      </div>
    )
    return null
  }
}

const onChange = (props, type, name) => {
  if (type !== 'select') return
  if (name === 'roles') return props.onChangeRole
  return props.onChange
}

const renderInputGroups = (props) => {
  return props.fields.map(field =>{
    return (
      <FormGroup key={field.name}>
        { renderBottomSection(field) }
        <Label for={field.name}>{field.label ? field.label + ':' : ''}</Label>
        { field.name === 'roles' ?
          <Select
            multi={true}
            delimiter=','
            joinValues={true}
            key='roles'
            labelKey='name'
            valueKey='id'
            onChange={props.onChangeRole}
            value={props.roles}
            options={field.options}
          /> :
          <Input
            autoComplete='off'
            type={field.type}
            name={field.name}
            id={field.name}
            maxLength={field.maxlength}
            defaultValue={field.value}
            placeholder={field.placeholder}
            onChange={onChange(props, field.type)}
          >
          { renderOptions(field.options) }
          </Input>
        }
        { renderErrors(props, field['name'])}
      </FormGroup>
    )
  })
}

const FormContainer = (props) => {
  return (
    <Container fluid>
      <Card>
        <div className='header'>
          <h4 className='title'>{props.formTitle}</h4>
        </div>
        <div className='content'>
          <Form onSubmit={props.onSubmit}>
            {renderInputGroups(props)}
            {props.children}
          </Form>
        </div>
      </Card>
    </Container>
  )
}

export default FormContainer
