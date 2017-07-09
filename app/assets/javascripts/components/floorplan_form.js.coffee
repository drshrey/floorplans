@FloorplanForm = React.createClass
  getInitialState: ->
    display_name: '',
    blueprint: '',
    project_id: @props.project_id
  handleValueChange: (e) ->
    valueName = e.target.name
    @setState "#{ valueName }": e.target.value
  valid: ->
    @state.display_name && @state.blueprint
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/floorplans', { floorplan: @state }, (data) =>
      @props.handleNewFloorplan data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Display Name'
          name: 'display_name'
          value: @state.display_name
          onChange: @handleValueChange
        React.DOM.input
          type: 'file'
          className: 'form-control'
          placeholder: 'Blueprint'
          name: 'blueprint'
          value: @state.blueprint
          onChange: @handleValueChange
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: !@valid()
          'Create Floorplan'
