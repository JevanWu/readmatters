$ ->
  $(document).on "click", ".options .option", ->
    option = $(this).data("option")
    $(".option").removeClass("selected")
    $(this).toggleClass("selected", true)
    $("#get_method_" + option).prop("checked", true)
