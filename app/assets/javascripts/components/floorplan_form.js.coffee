@FloorplanForm = React.createClass
  getInitialState: ->
    display_name: '',
    blueprint: '',
    project_id: @props.project_id
    filepath: '',
  getBase64: (file) ->
     reader = new FileReader();
     reader.readAsDataURL(file);
     blueprint_result = reader.onload = (e) => @setState "blueprint": e.target.result
     return blueprint_result
  handleValueChange: (e) ->
    valueName = e.target.name
    if valueName == "blueprint"
      file = document.querySelector('input[type=file]').files[0];
      @setState "filepath": e.target.value
      @setState "blueprint": @getBase64(file)
      if this.state.display_name == ''
        @setState "display_name": file.name.split('.')[0]
    else
      @setState "#{ valueName }": e.target.value
  valid: ->
    @state.blueprint
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/floorplans', { floorplan: @state }, (data) =>
      if "status" in Object.keys(data) && data["status"] == "Updated"
        @props.updateFloorplan data.floorplan
      else
        @props.handleNewFloorplan data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    console.log(this.state)
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group floorplan-form'
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
          value: @state.filepath
          onChange: @handleValueChange
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: !@valid()
          'Create Floorplan'
