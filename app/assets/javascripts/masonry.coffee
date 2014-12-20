masonryLoad = ->
  msnry = new Masonry( "#container",
        itemSelector: '.item'
        isFitWidth: true
  )

$(window).on('load', masonryLoad)
#$(document).ready(masonryLoad)
$(document).on('page:load', masonryLoad)
