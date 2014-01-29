_ = require("underscore")

module.exports = (lineman) ->
  app = lineman.config.application
  config:
    assetFingerprint:
      options:
        findAndReplaceFiles: ["dist/**/*.js", "dist/**/*.css", "dist/**/*.html", "dist/**/*.xml"]
        keepOriginalFiles: false
      dist:
        files: _(app.assetFingerprint.dist.files).tap (files) ->
          files[0].src.unshift("webfonts/**", "img/**")
