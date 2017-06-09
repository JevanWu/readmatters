$ ->
  categories = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('tag'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: "prefetch_category_tags.json",
    remote: {
      url: "fetch_category_tags?keyword=%QUERY",
      wildcard: '%QUERY'
    }
  )

  categories.initialize()

  $('#category_list').tagsinput(
    trimValue: true,
    confirmKeys: [13, 32],
    typeaheadjs: {
      displayKey: 'tag',
      valueKey: 'tag',
      source: categories.ttAdapter()
    }
  )
