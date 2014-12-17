$ ->
  $(window).scroll ->
    if $("#container").length
      windowTop = $(window).scrollTop()
      anchorTop = $("#container").offset().top
      if windowTop >= anchorTop
        if $(".feedback-bar").hasClass("showup") then return
        $(".feedback-bar").addClass("showup")
      else
        if not $(".feedback-bar").hasClass("showup") then return
        $(".feedback-bar").removeClass("showup")
