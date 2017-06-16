// Define custom server-side HTTP routes for lineman's development server
//    These might be as simple as stubbing a little JSON to
//    facilitate development of code that interacts with an HTTP service
//    (presumably, mirroring one that will be reachable in a live environment).
//
//  It's important to remember that any custom endpoints defined here
//    will only be available in development, as lineman only builds
//    static assets, it can't run server-side code.
//
//  This file can be very useful for rapid prototyping or even organically
//    defining a spec based on the needs of the client code that emerge.
//
//
var fs = require('fs')

module.exports = {
  drawRoutes: function (app) {
    // Never let express try to serve a directory, b/c express redirects
    // from generated/join to generated/join/, which screws
    // up relative link pathing in a way that differs from heroku
    // Ironically, this means adding on a '.html' when the point of this
    // extension-rewrite was to omit it, but it doesn't cause any lasting
    // harm, just a silly location bar in dev-mode
    app.use(function(req, res, next) {
      if (!req.url.match(/\/$/)) return next()

      var url = req.url.replace(/\/$/, '')
      var path = 'generated' + url
      if (fs.existsSync(path)
        && fs.lstatSync(path).isDirectory()
        && fs.existsSync(path + '.html')) {
        res.redirect(url + '.html')
      } else {
        next()
      }
    })

    // Catch-all to support extension-rewriting for files
    // If a request would otherwise 404 (we only serve files, so if fs.exist
    // fails then it would 404), then tack on an .html if that one would exist
    // and serve it up (non-html URLs are canonical)
    app.get('/*', (req, res, next) => {
      var path = 'generated' + req.url
      var htmlPath = path + '.html'

      if (!fs.existsSync(path) && fs.existsSync(htmlPath)) {
        res.sendfile(htmlPath)
      } else {
        next()
      }
    })
  }
}
