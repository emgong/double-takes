root = this

root.Sidebar = class Sidebar
  init: ->
    $("#right-menu").sidr
      name: "sidr-right"
      side: "right"

    $(".close").on eventType(), ->
      $.sidr("close", "sidr-right")
    @

eventType = ->
  return 'touchstart' if 'ontouchstart' of document.documentElement
  'click'
