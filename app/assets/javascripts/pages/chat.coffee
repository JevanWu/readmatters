$ ->
  $(".recipient-list").on "click", ".recipient", ->
    friend_id = $(this).data("friend_id")
    $ele = $(this)
    $.ajax(
      url: "/conversations/fetch"
      dataType: "json"
      method: "get"
      data:
        friend_id: friend_id,
      success: (ret) ->
        $("#conversations-list").html(ret.conversation_html)
        $ele.find(".unread-count").remove()
        return
      error: ->
        return
    )

  # send message
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

