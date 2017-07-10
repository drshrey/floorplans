@Floorplans = React.createClass
  getInitialState: ->
    floorplans: @props.floorplans
  getDefaultProps: ->
    floorplans: []
  addFloorplan: (floorplan) ->
    floorplans = @state.floorplans.slice()
    floorplans.push floorplan
    @setState floorplans: floorplans
  updateFloorplan: (floorplan) ->
    floorplans = @state.floorplans.slice()
    console.log('update floorplan')
    console.log(floorplans)
    console.log(floorplan)
    for fp in floorplans
      if fp.id == floorplan.id
        console.log('updating')
        fp.s3_url = floorplan.s3_url
        fp.filepath = floorplan.filepath
    @setState floorplans: floorplans
  render: ->
    React.DOM.div
      className: 'floorplans'
      React.DOM.h4
        className: 'title'
        'Floorplans'
      React.createElement FloorplanForm, updateFloorplan: @updateFloorplan, handleNewFloorplan: @addFloorplan, project_id: @props.project_id
      for floorplan in @state.floorplans
        React.createElement Floorplan, key: floorplan.id, floorplan: floorplan
