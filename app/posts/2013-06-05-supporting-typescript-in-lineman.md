---
title: "Supporting TypeScript in Lineman.js"
author:
  name: "Jason Karns"
  url: "http://jason.karns.name"
tldr:
  title: "Adding TypeScript support to Lineman is easy!"
  body: """
        1) Add `grunt-typescript` task to project
        2) Configure Lineman to load and run the task
        3) Write TypeScript
        4) Profit!
        """
---

Lineman is a great tool for building client-side applications. Out of the box,
it supports CoffeeScript, LESS, SASS, and (of course) JavaScript and CSS. But
because Lineman is built on [Grunt](http://gruntjs.com), it is easy to add any
grunt task to the Lineman toolchain. Today, let's see how we would add
TypeScript support to a Lineman project.

Here's a rundown of the necessary steps:

1. [Add the typescript grunt task to your project](#add-ts-dependency)
2. [Configure Lineman to load the grunt-typescript task and provide
   configuration for the task itself](#load-ts-task)
3. [Add a TypeScript file to be compiled](#add-ts-src)
4. [Add the TypeScript task to Lineman's build/run processes](#add-ts-to-build)
5. [Add typescript-generated javascript as a source for the `concat`
   task](#concat-ts-js)

Let's start with a fresh Lineman project.

```sh
$ lineman new ts-test
$ cd ts-test
```

<h1 id="add-ts-dependency">Add Dependency</h1>

Add the `grunt-typescript` NPM module as a dependency in your project by adding
it to `package.js`.

```javascript
"dependencies": {
  "lineman": "~0.7.1",
  "grunt-typescript": "0.1.6"
},
```

Running `npm install` should leave you with `grunt-typescript` and `lineman`
under `node_modules`. At this point, the grunt-typescript task is available to
Lineman, but isn't being loaded, so Grunt isn't aware of it. Verify this by
running `lineman grunt typescript`. You should get:

```sh
Warning: Task "typescript" not found. Use --force to continue.
Aborted due to warnings.
```

<h1 id="load-ts-task">Load the Task</h1>

Configure Lineman to load the `grunt-typescript` NPM module by adding it to the
`loadNpmTasks` array in `config/application.js`. Lineman will invoke [Grunt's
`loadNpmTasks` method](http://gruntjs.com/api/grunt#grunt.loadnpmtasks) on each
task in this array. We must also provide the task with its associated config
block. This should be the same configuration block that would normally be added
to `Gruntfile.js`.

```javascript
loadNpmTasks: ['grunt-typescript'],

typescript: {
  compile: {
    src: 'app/js/**/*.ts',
    dest: 'generated/js/app.ts.js'
  }
}
```

Now running `lineman grunt typescript` should give you:

```sh
Running "configure" task

Running "typescript:compile" (typescript) task
js: 0 files, map: 0 files, declaration: 0 files

Done, without errors.
```

<h1 id="add-ts-src">Add some TypeScript</h1>

Create a new file `app/js/greeter.ts`. This will be the TypeScript source that
is compiled into JavaScript. If you remember our typescript config block
specifies the source as 'app/js/**/*.ts', so any filename with a '.ts' extension
(within any subdirectory) will be compiled into the same JavaScript file. (For
more info, refer to `grunt-typescript`'s
[configuration](https://github.com/k-maru/grunt-typescript).)

```typescript
function Greeter(greeting: string) {
  this.greeting = greeting;
}
```

Now running `lineman grunt typescript` should give you:

```bash
Running "configure" task

Running "typescript:compile" (typescript) task
File ts/generated/js/app.ts.js created.
js: 1 file, map: 0 files, declaration: 0 files

Done, without errors.
```

Now we've got the task working independently from the Lineman build process. For
any arbitrary grunt task, this would be sufficient; simply run `lineman grunt
&lt;task&gt;`. However, if we run `lineman build`, the typescript task will not
be run. Let's add it to the Lineman build process.

<h1 id="add-ts-to-build">Compile during Lineman build</h1>

You can add grunt tasks to either the beginning or the end of the Lineman build
process using `prependTasks` or `appendTasks`, respectively. Since we want the
generated JavaScript that the TypeScript compiler emits to also be concatenated
and minified with the rest of the app, we need the typescript task to run before
the other Lineman tasks. We also want this task to run in both `dev` and `dist`
phases, so we'll add the `typescript` task to `prependTasks:common` array in
`config/application.js`.

```javascript
prependTasks: {
  common: ['typescript']
},
```

Now we've got the task running as part of the Lineman build process. However,
the typescript-generated javascript is not being concatenated/minified with the
rest of our application. We need to add the typescript-generated javascript to
the [`concat` task's source
list](https://github.com/testdouble/lineman/blob/7a73c9786594d1e3ec48d9c1affa479e0c78d1bd/config/application.coffee#L80).

<h1 id="concat-ts-js">Concatenate/Minify</h1>

There are a number of different ways to do this. One of which, is to simply
modify the concat-task configuration block in `config/application.js`.

```javascript
// save off the current config object instead of directly exposing it via module.exports
var config = require(process.env['LINEMAN_MAIN']).config.extend('application', {
  // ... this remains untouched
}

// add the typescript-generated js as a concat source
config.concat.js.src.push('generated/js/app.ts.js');

// export the modified config
module.exports = config;
```

Now when we run `lineman build` our Greeter function is compiled from TypeScript
into JavaScript, concatenated along with the rest of the application JavaScript
('generated/js/app.js') and minified ('dist/js/app.min.js')!
