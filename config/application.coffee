module.exports = (lineman) ->
  loadNpmTasks: lineman.config.application.loadNpmTasks.concat('grunt-html-validation', 'grunt-htmlhint', 'grunt-sass')

  appendTasks:
    common: lineman.config.application.appendTasks.common.concat("copy:dev")
    dist: lineman.config.application.appendTasks.common.concat("copy:dist")

  prependTasks:
    common: lineman.config.application.prependTasks.common.concat("sass")

  removeTasks:
    common: lineman.config.application.removeTasks.common.concat(
      "pug:templates", "jst", "jshint")
    dist: lineman.config.application.removeTasks.dist.concat("pages:dist")

  enableAssetFingerprint: if process.env.HEROKU_APP_NAME == "testdoubleblog" then true else false

  assetFingerprint:
    options:
      cdnPrefixForRootPaths: "//cdn.testdouble.com"

  markdown:
    options:
      title: "<%= pkg.title %>"
      dateFormat: 'MMMM Do, YYYY'

  htmlhint:
    files:
      src: "generated/**/*.html"
    options:
      'tagname-lowercase': true, 'attr-lowercase': true, 'attr-value-double-quotes': true,
      'attr-value-not-empty': true, 'doctype-first': true, 'tag-pair': true, 'tag-self-close': true,
      'spec-char-escape': true, 'id-unique': true, 'src-not-empty': true, 'head-script-disabled': true,
      'img-alt-require': true, 'doctype-html5': true, 'id-class-value': true, 'style-disabled': true

  sass:
    compile:
      options:
        includePaths: lineman.config.application.sass.compile.options.includePaths.concat(
          require('bourbon').includePaths,
          require('testdouble-style').includePaths
        )

  images:
    files:
      "node_modules/testdouble-style/img": "node_modules/testdouble-style/img/**/*.*"

  webfonts:
    files:
      "node_modules/testdouble-style/webfonts": "node_modules/testdouble-style/webfonts/**/*.*"

  validation:
    files:
      src: "generated/**/*.html"
    options:
      relaxerror: [
        "Bad value X-UA-Compatible for attribute http-equiv on element meta."
        "Bad value source for attribute rel on element a: The string source is not a registered keyword or absolute URL."
      ]

  pug:
    pagesDev:
      (pugOptions = options:
        data:
          site:
            title: "Test Double | Custom Software Development | Columbus Ohio")
    pagesDist: pugOptions

  watch:
    pugPages:
      files: [
        "<%= files.pug.pageRoot %><%= files.pug.pages %>",
        "<%= files.pug.templates %>", "app/partials/**/*.pug"
      ]
    pugTemplates:
      tasks: []
