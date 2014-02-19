module.exports = require(process.env['LINEMAN_MAIN']).config.extend "application",

  loadNpmTasks: [ 'grunt-contrib-copy', 'grunt-html-validation', 'grunt-htmlhint' ]

  appendTasks:
    common: "copy:dev"
    dist: "copy:dist"

  enableSass: true
  enableAssetFingerprint: true

  markdown:
    options:
      author: "the test double agents"
      title: "Test Double | Our Thinking"
      description: "the official blog of test double"
      url: "http://blog.testdouble.com"
      dateFormat: 'MMMM Do, YYYY'

    dev:
      context:
        cdn: ""

    dist:
      context:
        cdn: "http://cdn.testdouble.com"

  sass:
    options:
      bundleExec: true

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
