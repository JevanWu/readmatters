$ ->
  $("#insert-summary").click ->
    summary = $(this).data("summary")
    $("#product_summary").text(summary)
    summer_note = $("#product_summary")
    summer_note.code summer_note.val()
