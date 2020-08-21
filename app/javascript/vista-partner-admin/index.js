import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import App from './App'
import WebpackerReact from "webpacker-react/hmr"

WebpackerReact.setup({ App }) // ES6 shorthand for {Hello: Hello}

if (module.hot)
  module.hot.accept("./App", () => WebpackerReact.renderOnHMR(App))

