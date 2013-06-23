$ ->
  $('.green-strip').on 'click', ->
    $('html,body').animate(scrollTop: document.body.scrollHeight, 222)

  $('footer').on 'click', ->
    $('html,body').animate(scrollTop: 0, 222)


