$ ->
  $("#add-photo").click ->
    $("#upload-photo").click()

  $("#more-photo").click ->
    $("#upload-photo").click()

  $("#upload-photo").fileupload
    url: "http://localhost:3000/products/create_photo"
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
      $("#more-photo").parent().before("<div class='col-md-3'><div class='image-box'><img src='" + data.result.photo + "'></div></div>")
      return
    error: (data) ->
      return


