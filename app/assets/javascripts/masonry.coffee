document.addEventListener("turbolinks:load", ->
  container = $("#container")
  container.imagesLoaded( ->
    container.masonry({ itemSelector: '.item', isFitWidth: true })
  )

  $(document).scroll ->
    if($(document).scrollTop() >= 230)
      $.ajax(
        url: "/fetch_more_books"
        dataType: "json"
        method: "get"
        success: (ret) ->
          $items = ret.html
          container.append($items).masonry( 'appended', $item, true);
      )
)
