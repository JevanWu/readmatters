document.addEventListener("turbolinks:load", ->
  load_over = false
  container = $("#container")
  container.imagesLoaded( ->
    container.masonry({ itemSelector: '.item', isFitWidth: true })
  )

  $(document).scroll ->
    if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) && !load_over
      last_id = $(".item").last().data("id")
      $.ajax(
        url: "/fetch_more_books"
        data: { last_id: last_id }
        dataType: "json"
        method: "get"
        success: (ret) ->
          if ret.html.length == 0
            load_over = true
          else
            $items = $(ret.html)
            container.append($items).masonry('appended', $items, true)
      )
)
