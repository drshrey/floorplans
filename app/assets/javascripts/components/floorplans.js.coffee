@Floorplans = React.createClass
  getInitialState: ->
    floorplans: @props.floorplans
  getDefaultProps: ->
    floorplans: []
  addFloorplan: (floorplan) ->
    floorplans = @state.floorplans.slice()
    floorplans.push floorplan
    @setState floorplans: floorplans
  render: ->
    React.DOM.div
      className: 'floorplans'
      React.DOM.h1
        className: 'title'
        'Floorplans'
      React.createElement FloorplanForm, handleNewFloorplan: @addFloorplan, project_id: @props.project_id
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null
          React.DOM.th null, 'Display Name'
          React.DOM.th null, 'Blueprint'
        React.DOM.tbody null,
          for floorplan in @state.floorplans
            React.createElement Floorplan, key: floorplan.id, floorplan: floorplan
