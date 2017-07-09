@ProjectDetail = React.createClass
  render: ->
    React.DOM.div
      className: 'project-detail'
      React.DOM.h1
        className: 'title'
        @props.data.title
      React.DOM.h5
        className: 'created-at'
        'Created ' + @props.data.created_at
      React.createElement Floorplans, floorplans: @props.floorplans, project_id: @props.data.id
