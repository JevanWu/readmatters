$ ->
  $("#conversations-list").on "click", ".btn-send", ->
    var conversation_id = $(this).data("conversation_id")
    var user_id = $(this).data("user_id")
    $.ajax(
      url: "/conversations/" + conversation_id + "/messages"
      dataType: "json"
      method: "post"
      data:
        user_id: user_id
      success: (ret) ->
        var conversation = $('#conversations-list').find("[data-conversation-id='" + ret.conversation_id + "']");
        conversation.find('.message-list').append("<%= j(render 'messages/message', message: @message, user: current_user) %>");
        conversation.find('textarea').val('');
        return
      error: ->
        return
    )
