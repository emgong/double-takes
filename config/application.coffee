# Exports an object that defines
#  all of the configuration needed by the projects'
#  depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = require(process.env['LINEMAN_MAIN']).config.extend "application",

  loadNpmTasks: [ 'grunt-contrib-copy', 'grunt-html-validation', 'grunt-htmlhint' ]

  markdown:
    options:
      author: "the test double agents"
      title: "Test Double | Our Thinking"
      description: "the official blog of test double"
      url: "http://blog.testdouble.com"
      rssCount: 10
      dateFormat: 'MMMM Do, YYYY'
      layouts:
        wrapper: "app/templates/wrapper.us"
        index: "app/templates/index.us"
        post: "app/templates/post.us"
        archive: "app/templates/archive.us"
      paths:
        posts: "app/posts/*.md"
        pages: "app/pages/**/*.md"
        index: "index.html"
        archive: "archive.html"
        rss: "index.xml"

    dev:
      dest: "generated"
      context:
        js: "/js/app.js"
        css: "/css/app.css"
        cdn: ""

    dist:
      dest: "dist"
      context:
        js: "/js/app.js"
        css: "/css/app.css"
        cdn: "http://cdn.testdouble.com"

  # Use grunt-markdown-blog in lieu of Lineman's built-in pages task
  prependTasks:
    common: "markdown:dev"
    dist: "markdown:dist"
  appendTasks:
    common: "copy:dev"
    dist: "copy:dist"
  removeTasks:
    common: "pages:dev"
    dist: "pages:dist"

  enableSass: true
  enableAssetFingerprint: true

  sass:
    compile:
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

  watch:
    markdown:
      files: ["app/posts/*.md", "app/templates/*.us"]
      tasks: ["markdown:dev"]
