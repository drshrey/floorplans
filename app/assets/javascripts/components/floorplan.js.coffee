@Floorplan = React.createClass
  render: ->
    React.DOM.tr
      className: 'floorplan-row'
      React.DOM.td null, @props.floorplan.display_name
      React.DOM.td null, @props.floorplan.blueprint
