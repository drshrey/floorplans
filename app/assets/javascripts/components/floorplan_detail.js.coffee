@VersionedFileForm = React.createClass
  getInitialState: ->
    blueprint: '',
    floorplan_id: @props.floorplan_id
    filename: '',
  getBase64: (file) ->
     reader = new FileReader();
     reader.readAsDataURL(file);
     blueprint_result = reader.onload = (e) =>
       console.log(e.target.result)
       @setState "blueprint": e.target.result
     return blueprint_result
  handleValueChange: (e) ->
    file = document.querySelector('input[type=file]').files[0];
    @setState "filename": @props.filename
    @setState "blueprint": @getBase64(file)
  handleSubmit: (e) ->
    e.preventDefault()
    $(".loader").css('visibility', 'visible')
    $.post '/versioned_files', { versioned_file: @state  }, (data) =>
      window.location.href = '/floorplans/' + @props.floorplan_id
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group versioned-file-form'
        React.DOM.input
          type: 'file'
          accept: 'image/*, application/pdf'
          className: 'form-control'
          placeholder: 'Blueprint'
          name: 'blueprint'
          value: @state.filename
          onChange: @handleValueChange
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          'Add File'
      React.DOM.div
        className: 'loader'

@FloorplanDetail = React.createClass
  getInitialState: ->
    versioned_files: @props.versioned_files
  addVersionedFile: (versioned_file) ->
    current = @state.versioned_files
    current.push(versioned_file)
    console.log(current)
    @setState "versioned_files": current
  handleVersionFileDelete: (e) ->
    floorplan = @props.floorplan
    $.ajax '/versioned_files/' + e.target.name,
      type: 'DELETE',
      success: ->
        window.location.href = '/floorplans/' + floorplan.id

  render: ->
    React.DOM.div
      className: 'floorplan-detail'
      React.DOM.h1
        className: 'title'
        @props.floorplan.display_name

      React.DOM.img
        width: 100
        height: 100
        src: @state.versioned_files.slice(-1)[0].thumb_image_url
      React.DOM.h5
        className: 'created-at'
        'Created ' + @props.floorplan.created_at
      React.DOM.hr null

      React.createElement VersionedFileForm, addVersionedFile: @addVersionedFile, floorplan_id: @props.floorplan.id, filename: @state.versioned_files[0].filename
      React.DOM.br null
      for versioned_file, index in @state.versioned_files
        React.DOM.h5 null,
          React.DOM.a
            href: versioned_file.s3_url
            "v" + versioned_file.version_number + ": " + versioned_file.filename + ", created: " + versioned_file.created_at
          React.DOM.button
            onClick: @handleVersionFileDelete
            name: versioned_file.id
            className: 'btn btn-danger versioned-file-delete'
            'Delete v' + (index + 1)
