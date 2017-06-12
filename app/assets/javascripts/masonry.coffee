document.addEventListener("turbolinks:load", ->
  container = $("#container")
  container.imagesLoaded( ->
    container.masonry({ itemSelector: '.item', isFitWidth: true })
  )

  $(document).scroll ->
    if $(window).scrollTop() + $(window).height() >= $(document).height() - 100
      last_id = $(".item").last().data("id")
      $.ajax(
        url: "/fetch_more_books"
        data: { last_id: last_id }
        dataType: "json"
        method: "get"
        success: (ret) ->
          $items= $(ret.html)
          container.append($items).masonry('appended', $items, true)
      )
)
