@Projects = React.createClass
  getInitialState: ->
    projects: @props.data
  getDefaultProps: ->
    projects: []
  addProject: (project) ->
    projects = @state.projects.slice()
    projects.push project
    @setState projects: projects
  render: ->
    React.DOM.div
      className: 'projects'
      React.DOM.h1
        className: 'title'
        'Projects'
      React.createElement ProjectForm, handleNewProject: @addProject
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null
          React.DOM.th null, 'Title'
          React.DOM.th null, 'Created At'
        React.DOM.tbody null,
          for project in @state.projects
            React.createElement Project, key: project.id, project: project
