# Exports an object that defines
#  all of the configuration needed by the projects'
#  depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = require(process.env['LINEMAN_MAIN']).config.extend "application",

  markdown:
    options:
      author: "the test double agents"
      title: "test double | double takes"
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
        js: "/js/app.min.js"
        css: "/css/app.min.css"

  # Use grunt-markdown-blog in lieu of Lineman's built-in homepage task
  prependTasks:
    common: "markdown:dev"
    dist: "markdown:dist"
  removeTasks:
    common: "homepage:dev"
    dist: "homepage:dist"

  enableSass: true

  sass:
    compile:
      options:
        bundleExec: true

  watch:
    markdown:
      files: ["app/posts/*.md", "app/templates/*.us"]
      tasks: ["markdown:dev"]
