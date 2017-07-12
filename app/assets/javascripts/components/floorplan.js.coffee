@Floorplan = React.createClass
  handleClick: ->
    window.location.href = '/floorplans/' + @props.floorplan.id
  render: ->
    React.DOM.div
      onClick: @handleClick
      style: {background: '#ffe628'}
      className: 'floorplan-row'
      React.DOM.b null, @props.floorplan.display_name
      React.DOM.br null
      "last updated " + @props.floorplan.updated_at
      React.DOM.img
        src: @props.versioned_files.slice(-1)[0].thumb_image_url
        width: 100
        height: 100
