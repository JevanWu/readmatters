$ ->
  $("#cart .number-of-items").html("<%= j(current_cart.number_of_items.to_s) %>")
