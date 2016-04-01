module.exports = (lineman) ->
  loadNpmTasks: lineman.config.application.loadNpmTasks.concat('grunt-html-validation', 'grunt-htmlhint', 'grunt-sass')

  appendTasks:
    common: "copy:dev"
    dist: "copy:dist"

  prependTasks:
    common: lineman.config.application.prependTasks.common.concat("sass")

  enableAssetFingerprint: if process.env.HEROKU_APP_NAME == "testdoubleblog" then true else false

  assetFingerprint:
    options:
      cdnPrefixForRootPaths: "http://cdn.testdouble.com"

  markdown:
    options:
      title: "<%= pkg.title %>"
      dateFormat: 'MMMM Do, YYYY'

  copy:
    dev:
      files: [ expand: true, cwd: 'static', src: '**', dest: 'generated' ]
    dist:
      files: [ expand: true, cwd: 'static', src: '**', dest: 'dist' ]

  htmlhint:
    files:
      src: "generated/**/*.html"
    options:
      'tagname-lowercase': true, 'attr-lowercase': true, 'attr-value-double-quotes': true,
      'attr-value-not-empty': true, 'doctype-first': true, 'tag-pair': true, 'tag-self-close': true,
      'spec-char-escape': true, 'id-unique': true, 'src-not-empty': true, 'head-script-disabled': true,
      'img-alt-require': true, 'doctype-html5': true, 'id-class-value': true, 'style-disabled': true

  validation:
    files:
      src: "generated/**/*.html"
    options:
      relaxerror: [
        "Bad value X-UA-Compatible for attribute http-equiv on element meta."
        "Bad value source for attribute rel on element a: The string source is not a registered keyword or absolute URL."
      ]
