// import Popper from 'popper.js'
// import VistaAdmin from 'vista-admin'
var componentRequireContext = require.context("components", true)
var ReactRailsUJS = require("react_ujs")
ReactRailsUJS.useContext(componentRequireContext)
