@Project = React.createClass
  handleClick: ->
    window.location.href = '/projects/' + @props.project.id
  render: ->
    React.DOM.tr
      onClick: @handleClick
      className: 'project-row'
      React.DOM.td null, @props.project.title
      React.DOM.td null, @props.project.created_at      
