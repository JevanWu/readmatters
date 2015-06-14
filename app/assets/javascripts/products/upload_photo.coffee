$ ->
  $("#add-photo").click ->
    $("#upload-photo").click()

  $("#upload-photo").fileupload
    url: "http://localhost:3000/products/create_photo"
    dataType: "json"
    method: "post"
    add: (e, data) ->
      data.formData = {
        product_id: $("#upload-image").data()
      }
      data.submit()
      return
    done: (e, data) ->
      alert("done")
      return
    error: (data) ->
      return


