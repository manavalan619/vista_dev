import React, { Component } from 'react'
import { ListGroup, ListGroupItem, ListGroupItemText } from 'reactstrap'
import './ComponentList.css'
import ChevronLeft from 'react-icons/lib/fa/chevron-left'
import ChevronDown from 'react-icons/lib/fa/chevron-down'
import IconEdit from 'react-icons/lib/fa/edit'
import IconAdd from 'react-icons/lib/fa/plus-square-o'
import axios from 'axios'
import { Link } from 'react-router-dom'

export default class ComponentList extends Component {
  static defaultProps = {
    items: []
  }

  renderBranches() {
    const { openChevron: unitId, branches } = this.props

    if (!branches.length) {
      return (
        <ListGroupItem style={{ fontStyle: 'italic' }}>
          Currently no branches for this unit
        </ListGroupItem>
      )
    }

    return branches.map(branch => {
      const { openChevron: unitId } = this.props
      return (
        <ListGroupItem
          key={`branch${branch.id}`}
          style={{ flex:1, justifyContent:'space-between' }}
        >
          <ListGroupItemText style={{margin: '2px'}}>
            <Link to={`/units/${unitId}/branches/${branch.id}/edit`}>
              {branch.name}
            </Link>
          </ListGroupItemText>
        </ListGroupItem>
      )
    })
  }

  renderListGroup(id) {
    if (this.props.openChevron !== id){
      return null
    }

    let visibilty = 'hidden'
    if (this.props.loadedChevron === id) {
      visibilty = 'show'
    }

    return (
      <ListGroup className={`expandable ${visibilty}`} key={`branchGroup${id}`}>
        { this.renderBranches() }
      </ListGroup>
    )
  }

  renderChevron(id) {
    if (this.props.openChevron === id) {
      return <ChevronDown onClick={this.toggleChevron.bind(this,id)} />
    }
    return <ChevronLeft onClick={this.toggleChevron.bind(this,id)} />
  }

  toggleChevron(id) {
    let newId = id
    if (this.props.openChevron === id){
      newId = null
    } else {
      axios.get(`/units/${id}/branches`).then(({data}) => {
        this.props.actions.fillBranchList(data)
        this.props.actions.registerItemsLoaded(id)
        let list = document.querySelector('.expandable')
        list.classList.add('show')
      })
    }
    this.props.actions.changeOpenChevron(newId)
  }

  onClick(a){
    console.log('Target',a.target)
  }

  editUnitModal(item){
    this.props.actions.viewUnit(item)
    this.props.editUnitModal(item)
  }

  onAddBranchModal(item){
    console.log(item)
    this.props.actions.viewUnit(item);
    this.props.addBranchModal()
  }

  renderList = () => {
    const { items } = this.props
    if (!this.props.items.length) { return null }
    return this.props.items.map((item) => {
      return (
        <div key={item.id}>
          <ListGroupItem
            style={{flex:1, justifyContent:'space-between'}}
          >
            { this.renderListGroup() }
            <ListGroupItemText style={{margin: '2px'}}>
              <Link to={`/units/${item.id}`}>{item.name}</Link>
            </ListGroupItemText>
            <div style={{ width: '70px', display: 'flex', justifyContent: 'space-between',alignItems:'center'}}>
              <div className='edit-tooltip'>
                <IconAdd onClick={this.onAddBranchModal.bind(this, item) }/>
                <span className='edit-tooltiptext'>Add branch</span>
              </div>
              <div className='edit-tooltip'>
                { this.renderChevron(item.id)}
              </div>
            </div>
          </ListGroupItem>
          {this.renderListGroup(item.id)}
        </div>
      )
    })
  }

  render(){
    return (
      <ListGroup className='list-group-root' >
        { this.renderList() }
      </ListGroup>
    )
  }
}
