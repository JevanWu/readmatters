$ ->
  $(document).on "click", "#add-photo", ->
    $("#upload-photo").click()

  $(document).on "click", "#more-photo", ->
    $("#upload-photo").click()

  $(".open-survey").click ->
    window.open("http://readmatters.mikecrm.com/tXRG1hE", "_blank")

  $("#upload-photo").fileupload
    url: "/products/create_photo"
    dataType: "json"
    method: "post"
    add: (e, data) ->
      data.formData = {
        product_id: $("#upload-photo").data("product")
      }
      data.submit()
      return
    done: (e, data) ->
      if $(".upload-photo").is(":visible")
        $(".upload-photo").hide()
        $(".photo-show").show()
      $("#more-photo").parent().before("<div class='col-md-3'><div class='image-box' id='photo-#{data.result.id}' data-photo='" + data.result.id + "'><img src='" + data.result.photo + "'><i class='fa fa-trash-o'/></div></div>")
      # TODO: bind event to fa
      return
    error: (data) ->
      return

  $(".container").on "click", ".fa-trash-o", ->
    photo_id = $(this).parent().data("photo")
    if confirm("确认要删除吗？")
      $.ajax(
        url: "/products/delete_photo"
        dataType: "json"
        method: "delete"
        data:
          photo_id: photo_id
        success: (ret) ->
          $("#photo-#{photo_id}").parent().remove()
          return
        error: ->
          return
      )
    e.stopPropagation()


