import React, { Component } from 'react'
import { Table, Button, Badge } from 'reactstrap'
import { isURL } from 'validator'

const TableSection = (props) => {
  const { excludeFields = [] } = props
  const { mapFieldsToHeader, items, onClickRow } = props
  const fields = Object.keys(mapFieldsToHeader)

  const filteredFields = fields.filter(field => {
    return excludeFields.indexOf(field) < 0
  })

  const originalHeaderCount = filteredFields.length
  const extraFields = props.extraFields

  if (!!extraFields){
    extraFields().forEach((extraField)=>{
      filteredFields.push(extraField.textForHeader)
    })
  }

  const mapTableHeaders = () => filteredFields.map((columnName,index) => {
    return (
      <th key={index} >{ mapFieldsToHeader[columnName] }</th>
    )
  })

  const renderTableHeaders = () => (
    <thead>
      <tr key={'header'}>
        { mapTableHeaders() }
      </tr>
    </thead>
  )


  const unCamelCase = (word, col) =>
    col === 'type' ? word === 'StaffMember' ? 'User' :word && word.replace(/([a-z](?=[A-Z]))/g, '$1 ') : word


  const renderTableCells = (item) => filteredFields.map((columnName, index) => {
    if (index >= originalHeaderCount){
      let newIndex = index - originalHeaderCount
      let field = extraFields.call(this,item)[newIndex]
      return (
        <td key={`${item.id}-extrafield-${index}`} >
            {field.addedComponent }
        </td>
      )
    }
    // if the field is an array, render each value as a button
    if(Array.isArray(item[columnName])){
      return (
        <td key={item[columnName]} style={{ width:'80px'}}>
          { item[columnName].map((element)=> <Badge key={element.id} style={{margin: '1px'}}>{element.name}</Badge>) }
        </td>
      )
    }



    return (
      <td
        key={mapFieldsToHeader[columnName] + item[columnName]}
        style={{ textDecoration: item.suspended_at ? 'line-through': 'none' }}
      >{unCamelCase(item[columnName], columnName)}</td>
    )
  })

  const renderTableRows = () => items.map(item => {
    if (!item) return null
    if (!!onClickRow) {
      return (
        <tr
          className='clickable'
          onClick={onClickRow.bind(_, item)}
          key={item.id}
        >
          {renderTableCells(item)}
        </tr>
      )
    }
    return (
      <tr key={item.id}>{renderTableCells(item)}</tr>
    )
  })

  if (!items || !items.length) return null
  return (
    <Table hover={props.hover || !!onClickRow} size='sm' striped className='mt-3'>
      { renderTableHeaders() }
      <tbody>
        { renderTableRows() }
      </tbody>
    </Table>
  )
}

export default TableSection
