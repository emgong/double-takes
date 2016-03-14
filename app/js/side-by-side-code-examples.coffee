$ ->
  return unless $('.side-by-side-code-examples').length > 0
  $('pre').each (i, el) ->
    return if $(el).prev().prev().hasClass('wide')
    $(el).prev().addBack().wrapAll('<div class="inline-code-block"></div>')

