$ ->
  $(".recipient-list").on "click", ".recipient", ->
    conversation_id = $(this).data("conversation_id")
    $(".conversation-panel").hide()
    $("#conversation_" + conversation_id).show()

  $("#conversations-list").on "click", ".btn-send", ->
    conversation_id = $(this).data("conversation_id")
    user_id = $(this).data("user_id")
    body = $(this).siblings("textarea").val()
    $.ajax(
      url: "/conversations/" + conversation_id + "/messages"
      dataType: "json"
      method: "post"
      data:
        message:
          user_id: user_id,
          body: body
      success: (ret) ->
        conversation = $('#conversations-list').find("[data-conversation-id='" + conversation_id + "']")
        conversation.find('.message-list').append(ret.message_html)
        conversation.find('textarea').val('')
        scroll_last_message()
        return
      error: ->
        return
    )

  scroll_last_message = ->
    panel_body = $('#conversations-list .panel-body')
    height = panel_body[0].scrollHeight
    panel_body.scrollTop(height)

  scroll_last_message()

