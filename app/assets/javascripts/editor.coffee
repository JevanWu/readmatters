$ ->
    # to set summernote object
    # You should change '#post_content' to your textarea input id
    summer_note = $('.summernote')
    
    # to call summernote editor
    summer_note.summernote
      # to set options
      height:300
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
