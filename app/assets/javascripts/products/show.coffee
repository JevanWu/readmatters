$ ->
  $('.photo-show').magnificPopup(
    delegate: '.image-box',
    type: 'image',
    gallery: { enabled:true }
  )

  $(document).on "click", "#show-author-intro", ->
    $(".author-intro p").show()
    $(this).hide()

  $(document).on "click", "#show-catalog", ->
    $(".catalog p").show()
    $(this).hide()


  $(document).scroll ->
    if($(document).scrollTop() >= 230)
      $(".js-buy-it").addClass("fixed")
      $(".owner-frame").addClass("hidden")
    else
      $(".js-buy-it").removeClass("fixed")
      $(".owner-frame").removeClass("hidden")

