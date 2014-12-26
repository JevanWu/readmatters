$(document).ready( ->
  timelineAnimate
  timelineAnimate = (elem) ->
    return $(".timeline.animated .timeline-row").each((i) ->
      bottom_of_object = $(this).position().top + $(this).outerHeight()
      bottom_of_window = $(window).scrollTop() + $(window).height()
      if (bottom_of_window > bottom_of_object)
        return $(this).addClass("active")
    )
  
  timelineAnimate()
  return $(window).scroll( ->
    return timelineAnimate()
  )
)
