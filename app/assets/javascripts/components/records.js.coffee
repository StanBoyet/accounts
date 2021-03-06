@Records = React.createClass
  getInitialState: ->
    records: _.sortBy(@props.records, 'date').reverse();
    users: @props.users

  getDefaultProps: ->
    records: []
    users: []

  credits: ->
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  balance: ->
    @debits() + @credits()

  addRecord: (record) ->
    records = React.addons.update(@state.records, { $push: [record] })
    @setState records: _.sortBy(records, 'date').reverse()

  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records

  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records


  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        'Accounts'
      # React.DOM.div
      #   className: 'row'
      #   React.createElement AmountBox, type: 'success', amount: @credits(), text: 'Credit'
      #   React.createElement AmountBox, type: 'warning', amount: @debits(), text: 'Debit'
      #   React.createElement AmountBox, type: 'info', amount: @balance(), text: 'Balance'
      React.DOM.div
        className: 'row'
        React.createElement RecordForm, handleNewRecord: @addRecord, users: @state.users
      React.DOM.hr null
      React.DOM.table
        className: 'records-table small-12 table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Date'
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Spender'
            React.DOM.th null, 'Amount'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for record in @state.records
            React.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord
