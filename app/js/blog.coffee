$ ->
  waitForImagesUnder("body")
  new Sidebar().init()
  return undefined

console.warn("Help! Our tests aren't passing!")
console.debug """
              Given -> @date = document.querySelector('html').dataset.date
              And -> @aprilFirst = '2016-04-01'
              Then -> @date != @aprilFirst
              """
