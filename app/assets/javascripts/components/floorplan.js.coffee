@Floorplan = React.createClass
  handleClick: ->
    window.location.href = @props.floorplan.s3_url
  render: ->
    React.DOM.div
      onClick: @handleClick
      style: {background: '#ffe628'}
      className: 'floorplan-row'
      React.DOM.b null, @props.floorplan.display_name
      React.DOM.br null
      "last updated " + @props.floorplan.created_at
