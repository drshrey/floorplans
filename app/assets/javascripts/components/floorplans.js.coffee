@Floorplans = React.createClass
  getInitialState: ->
    floorplans: @props.floorplans,
    alert: ''
  getDefaultProps: ->
    floorplans: []
  addFloorplan: (floorplan) ->
    floorplans = @state.floorplans.slice()
    floorplans.push floorplan
    @setState floorplans: floorplans
    @setState alert: "Added " + floorplan.display_name
  updateFloorplan: (floorplan) ->
    floorplans = @state.floorplans.slice()
    changed = ''
    for fp in floorplans
      if fp.id == floorplan.id
        fp.s3_url = floorplan.s3_url
        fp.filepath = floorplan.filepath
        changed = fp
    @setState floorplans: floorplans
    @setState alert: "Updated " + changed.display_name
  render: ->
    React.DOM.div
      className: 'floorplans'
      React.DOM.h3
        className: 'alert'
        @state.alert
      React.DOM.h4
        className: 'title'
        'Floorplans'
      React.DOM.div
        className: 'loader'
      React.createElement FloorplanForm, updateFloorplan: @updateFloorplan, handleNewFloorplan: @addFloorplan, project_id: @props.project_id
      for floorplan in @state.floorplans
        React.createElement Floorplan, key: floorplan.id, floorplan: floorplan
