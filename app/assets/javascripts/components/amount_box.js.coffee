@AmountBox = React.createClass
  render: ->
    React.DOM.div
      className: 'column small-4'
      React.DOM.div
        className: "panel callout"
        React.DOM.div
          className: 'panel-heading'
          @props.text
        React.DOM.div
          className: 'panel-body'
          amountFormat(@props.amount)
