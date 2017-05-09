$ ->
  $(document).on "click", "#show-author-intro", ->
    $(".author-intro p").show()
    $(this).hide()

  $(document).on "click", "#show-catalog", ->
    $(".catalog p").show()
    $(this).hide()
