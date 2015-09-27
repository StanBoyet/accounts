@RecordForm = React.createClass
  getInitialState: ->
    title: ''
    date: ''
    amount: ''
    spender_id: @props.users[0].id
    recipient_ids: []
  handleMultipleSelect: (e) ->
    options = e.target.options
    selectedOptions = _.where(options, selected: true)
    @setState 'recipient_ids': _.pluck(selectedOptions, 'value')
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.title && @state.date && @state.amount
  handleSubmit: (e) ->
    e.preventDefault()
    console.log @state
    $.post '/records', { record: @state }, (data) =>
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
            name: 'recipients'
            multiple: true
            onChange: @handleMultipleSelect
            _.map @props.users, (recipient) ->
              React.DOM.option
                key: recipient.id
                value: recipient.id
                recipient.name
          React.DOM.div
            className: 'form-group'
            React.DOM.select
              className: 'form-control'
              placeholder: 'Users'
              name: 'spender_id'
              onChange: @handleChange
              _.map @props.users, (spender) ->
                React.DOM.option
                  key: spender.id
                  value: spender.id
                  spender.name
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
