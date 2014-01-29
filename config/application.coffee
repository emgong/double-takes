# Exports an object that defines
#  all of the configuration needed by the projects'
#  depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = require(process.env['LINEMAN_MAIN']).config.extend "application",

  loadNpmTasks: 'grunt-contrib-copy'

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

    dist:
      dest: "dist"
      context:
        js: "/js/app.js"
        css: "/css/app.css"

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

  watch:
    markdown:
      files: ["app/posts/*.md", "app/templates/*.us"]
      tasks: ["markdown:dev"]
