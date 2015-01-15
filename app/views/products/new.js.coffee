$ ->
  $(".form-horizontal").html("<%= j(render 'new_form', name: @name, kind: @kind, description: @description) %>")
  # to set summernote object
  # You should change '#post_content' to your textarea input id
  summer_note = $('#product_description')
  
  # to call summernote editor
  summer_note.summernote
    # to set options
    height:500
    codemirror:
      lineNumbers: true
      tabSize: 2
      theme: "solarized light"

  # to set code for summernote
  summer_note.code summer_note.val()
  
  # to get code for summernote
  summer_note.closest('form').submit ->
    summer_note.val summer_note.code()
    true
