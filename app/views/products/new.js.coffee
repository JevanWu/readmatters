$ ->
  debugger;

  categories = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('tag')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    prefetch: "fetch_category_tags.json"
  )

  categories.initialize()

  $('#category_list').tagsinput(
    typeaheadjs: {
      displayKey: 'tag',
      valueKey: 'tag',
      source: categories.ttAdapter()
    }
  )
