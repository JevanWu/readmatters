$ ->
  alert($.cookie("e21fa6e62141ca2d"))

  $(document).on 'click', '#signup', ->
    zhuge.track('Signup')

  $(document).on 'click', '#signin', ->
    zhuge.track('Signin')

  $(document).on 'click', '#publish-book', ->
    zhuge.track('Publish book')

  $(document).on 'click', '#create-product', ->
    zhuge.track('Create product')

  $(document).on 'click', '#add-to-cart', ->
    zhuge.track('Add to cart')

