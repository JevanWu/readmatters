$ ->
  $(document).on 'click', '#signup', ->
    zhuge.track('Signup', {
      'code': $.cookie("e21fa6e62141ca2d"),
    })

  $(document).on 'click', '#signin', ->
    zhuge.track('Signin', {
      'code': $.cookie("e21fa6e62141ca2d"),
    })

  $(document).on 'click', '#publish-book', ->
    zhuge.track('Publish book', {
      'code': $.cookie("e21fa6e62141ca2d"),
    })


  $(document).on 'click', '#create-product', ->
    zhuge.track('Create product', {
      'code': $.cookie("e21fa6e62141ca2d"),
    })


  $(document).on 'click', '#add-to-cart', ->
    zhuge.track('Add to cart', {
      'code': $.cookie("e21fa6e62141ca2d"),
    })


