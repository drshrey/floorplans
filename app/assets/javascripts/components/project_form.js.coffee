@ProjectForm = React.createClass
  getInitialState: ->
    title: ''
  handleValueChange: (e) ->
    valueName = e.target.name
    @setState "#{ valueName }": e.target.value
  valid: ->
    @state.title
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/projects', { project: @state }, (data) =>
      @props.handleNewProject data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group project-form'
        React.DOM.input
          type: 'text'
          className: 'project-title'
          placeholder: 'Enter a project title'
          name: 'title'
          value: @state.title
          onChange: @handleValueChange
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: !@valid()
          'Create'
