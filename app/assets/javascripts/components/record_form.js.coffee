@RecordForm = React.createClass
  getInitialState: ->
    title: ''
    date: ''
    amount: ''
    user_ids: []
  handleMultipleSelect: (e) ->
    options = e.target.options
    selectedOptions = _.where(options, selected: true)
    @setState 'user_ids': _.pluck(selectedOptions, 'value')
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.title && @state.date && @state.amount
  handleSubmit: (e) ->
    e.preventDefault()
    window.foo = @state
    $.post '/records', { record: @state }, (data) =>
      console.log data
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.div
      className: 'column small-12 large-offset-3 large-6 medium-offset-2 medium-8'
      React.DOM.form
        className: 'form-inline'
        onSubmit: @handleSubmit
        React.DOM.input
          type: 'date'
          className: 'form-control'
          placeholder: 'Date'
          name: 'date'
          value: @state.date
          onChange: @handleChange
        React.DOM.div
          className: 'form-group'
          React.DOM.input
            type: 'text'
            className: 'form-control'
            placeholder: 'Title'
            name: 'title'
            value: @state.title
            onChange: @handleChange
        React.DOM.div
          className: 'form-group'
          React.DOM.select
            className: 'form-control'
            placeholder: 'Users'
            name: 'users'
            multiple: true
            onChange: @handleMultipleSelect
            _.map @props.users, (user) ->
              React.DOM.option
                key: user.id
                value: user.id
                user.name
        React.DOM.div
          className: 'form-group'
          React.DOM.input
            type: 'number'
            className: 'form-control'
            placeholder: 'Amount'
            name: 'amount'
            value: @state.amount
            onChange: @handleChange
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: !@valid()
          'Create record'
