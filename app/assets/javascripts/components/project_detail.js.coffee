@ProjectDetail = React.createClass
  render: ->
    React.DOM.div
      className: 'project-detail'
      React.DOM.h1
        className: 'title'
        @props.data.title
      React.DOM.h4
        className: 'created-at'
        'Created ' + @props.data.created_at
