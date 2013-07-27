$ ->
  $('<div>').prependTo('body').
    css( position:'absolute', top:0, left:0, width:'100%', height: $('html').css('border-top-width')).
    on 'click', ->
      $('html,body').animate(scrollTop: document.body.scrollHeight, 222)

  $('footer').on 'click', ->
    $('html,body').animate(scrollTop: 0, 222)


