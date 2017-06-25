$ ->
  # $(window).scroll ->
  #   if $("#container").length
  #     windowTop = $(window).scrollTop()
  #     anchorTop = $("#container").offset().top
  #     if windowTop >= anchorTop
  #       if $(".feedback-bar").hasClass("showup") then return
  #       $(".feedback-bar").addClass("showup")
  #     else
  #       if not $(".feedback-bar").hasClass("showup") then return
  #       $(".feedback-bar").removeClass("showup")

  # $('#cart').popover('hide')

  $(document).on 'click', '.notice .close', ->
    $(this).parent().hide()

  $(document).on 'click', '.alert .close', ->
    $(this).parent().hide()

  lastScrollTop = 0
  $(document).scroll ->
    st = $(this).scrollTop()
    if st > lastScrollTop
      $(".footer").css("height", "0px")
    else
      $(".footer").css("height", "55px")
    lastScrollTop = st
