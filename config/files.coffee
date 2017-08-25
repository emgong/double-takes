module.exports = require(process.env["LINEMAN_MAIN"]).config.extend "files",

  sass:
    main: [
      "app/css/blog.sass"
    ]

  css:
    vendor: [
      "node_modules/testdouble-dot-com/vendor/css/**/*.css",
      "vendor/css/**/*.css"
    ]
  coffee:
    app: [
      "vendor/js/**/*.coffee",
      "app/js/**/*.coffee"
    ]

  js:
    vendor: [
      "vendor/js/jquery.js"
      "vendor/js/**/*.js"
    ]
