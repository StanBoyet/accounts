@amountFormat = (amount) ->
    Number(amount).toLocaleString() + ' €'

@camelize = (string) ->
  string.slice(0,1).toUpperCase() + string.slice(1, string.length)
