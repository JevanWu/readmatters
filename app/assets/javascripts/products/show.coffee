$ ->
  $("#show-author-intro").click ->
    $(".author-intro p").show()
    $(this).hide()

  $("#show-catalog").click ->
    $(".catalog p").show()
    $(this).hide()

