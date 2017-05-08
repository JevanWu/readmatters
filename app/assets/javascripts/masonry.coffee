document.addEventListener("turbolinks:load", ->
  container = $("#container")
  container.imagesLoaded( ->
    container.masonry({ itemSelector: '.item', isFitWidth: true })
  )
)
