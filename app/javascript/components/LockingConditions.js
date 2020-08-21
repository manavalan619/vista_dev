import React, { Component } from 'react'
import PropTypes from 'prop-types'
import Select from 'react-select'
import 'react-select/dist/react-select.css'

class LockingConditions extends Component {
  constructor(props) {
    super(props)
    this.state = {
      lockingConditions: this.props.lockingConditions
    }
  }

  addCondition = () => {
    this.setState(state => {
      return {
        lockingConditions: [
          ...state.lockingConditions,
          {
            question_id: null,
            answer: null
          }
        ]
      }
    })
  }

  removeCondition = (index) => {
    this.setState(state => {
      const { lockingConditions } = state
      lockingConditions.splice(index, 1)
      return { lockingConditions }
    })
  }

  selectQuestion = (selection, index) => {
    this.setState(state => {
      const { lockingConditions } = state
      return {
        lockingConditions: lockingConditions.map((condition, idx) => {
          if (idx === index) {
            return { question_id: selection.value, answer: condition.answer }
          }
          return condition
        })
      }
    })
  }

  selectAnswer = (selection, index) => {
    this.setState(state => {
      const { lockingConditions } = state
      return {
        lockingConditions: lockingConditions.map((condition, idx) => {
          if (idx === index) {
            return { question_id: condition.question_id, answer: selection.value }
          }
          return condition
        })
      }
    })
  }

  renderInput = (condition, index) => {
    const questionArray = this.props.questions.map(question => {
      return { value: question.id, label: question.title }
    })

    const answers = this.props.answers.filter(a => {
      return a.question_id === condition.question_id
    }).map(a => {
      return { value: a.title, label: a.title }
    })

    return (
      <div className="columns" key={`condition_${condition.question_id}_${condition.answer}`}>
        <div className="column">
          <div className="field">
            <label
              htmlFor={`condition${index}_category`}
              className="label">
              Question
            </label>
            <Select
              name={`question[locking_conditions[][question_id]]`}
              value={condition.question_id}
              onChange={(selection) => this.selectQuestion(selection, index)}
              options={questionArray}
            />
          </div>
        </div>
        <div className="column">
          <div className="field">
            <label
              htmlFor={`condition${index}_answer`}
              className="label">
              Answer
            </label>
            {answers.length ?
              <Select
                name={`question[locking_conditions[][answer]]`}
                value={condition.answer}
                onChange={(selection) => this.selectAnswer(selection, index)}
                options={answers}
              />
            : <input
              type="string"
              className="input"
              id={`condition${index}_answer`}
              name={`question[locking_conditions[][answer]]`}
              defaultValue={condition.answer}
            />}
          </div>
        </div>
        <div className="column is-1">
          <button
            type="button"
            className="button has-text-danger mt-1-8"
            aria-label="Remove"
            onClick={() => this.removeCondition(index)}>
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
      </div>
    )
  }

  render () {
    return (
      <div className="card mb-1">
        <div className='card-header'>
          <h3 className='card-header-title'>Locking Conditions</h3>
        </div>
        <div className="card-content">
          <input name={`question[locking_conditions[]]`} type='hidden' />
          {this.state.lockingConditions.map((c, i) => this.renderInput(c, i))}

          <button
            type="button"
            className="button is-primary is-fullwidth"
            onClick={this.addCondition}>
            Add condition
          </button>
        </div>
      </div>
    )
  }
}

LockingConditions.propTypes = {
  lockingConditions: PropTypes.array.isRequired,
  questions: PropTypes.array.isRequired,
  answers: PropTypes.array.isRequired
}

export default LockingConditions
