$ ->
  $(".form-horizontal").html("<%= j(render 'new_form', name: @name, kind: @kind, description: @description) %>")
