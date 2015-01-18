$ ->
  $("#cart .number-of-items").html("[<%= j(@cart.number_of_items.to_s) %>]")
