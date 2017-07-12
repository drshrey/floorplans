@Floorplans = React.createClass
  getInitialState: ->
    floorplans: @props.floorplans,
    alert: '',
    versioned_files: @props.versioned_files
  getDefaultProps: ->
    floorplans: []
  updateFloorplanMsg: (floorplan) ->
    @setState alert: "Updated " + floorplan.display_name
  addFloorplan: (floorplan) ->
    floorplans = @state.floorplans
    floorplans.push(floorplan)

    versioned_files = @state.versioned_files
    versioned_files[floorplan.id] = [floorplan.versioned_file]

    @setState floorplans: floorplans
    @setState versioned_files: versioned_files
    @setState alert: "Added " + floorplan.display_name
  render: ->
    console.log(@props)
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
      React.createElement FloorplanForm, updateFloorplanMsg: @updateFloorplanMsg, handleNewFloorplan: @addFloorplan, project_id: @props.project_id
      for floorplan in @state.floorplans
        React.createElement Floorplan, key: floorplan.id, floorplan: floorplan, versioned_files: @state.versioned_files[floorplan.id]
