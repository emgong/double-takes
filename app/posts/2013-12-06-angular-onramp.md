---
title: "Angular Onramp for the Backend Developer"
tldr:
  title: "A place to use our new toys"
  body: """
        Learning a new tech is much easier when we can use it today to build out features that matter.
        """
date: "2013-12-06"
author:
  name: "Zach Briggs"
  url: "http://twitter.com/theotherzach"
reddit: "true"
---

This tutorial is designed to give backend developers a place to put Angular to work for them, today. It starts with a hypothetical site which has table of records rendered server side. The tutorial gently guides the reader through moving the rendering from the server and to the client with Angular and uses the momentum from that to add two new features:

* Sort table by column
* Filter table by input field

Rather than adding a jQuery plugin we're going to use Angular to complete these requests.

# The Table To Start
<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Artist</th>
      <th>Album</th>
      <th>Time</th>
      <th>Download</th>
    </tr>
  </thead>

  <tbody>
      <td >My Love</td>
      <td >The Bird and the Bee</td>
      <td >Ray Guns Are Not Just The Future</td>
      <td >3:46</td>
      <td><a href="#">Download</a></td>
    </tr>
      <td >Neighbors</td>
      <td >The Long Division</td>
      <td >Multiply</td>
      <td >2:25</td>
      <td><a href="#">Download</a></td>
    </tr>
      <td >Middle Distance Runner</td>
      <td >Sea Wolf</td>
      <td >Leaves In The River</td>
      <td >3:28</td>
      <td><a href="#">Download</a></td>
    </tr>
      <td >Good Old Vinyl</td>
      <td >Jim Noir</td>
      <td >Jim Noir</td>
      <td >3:40</td>
      <td><a href="#">Download</a></td>
    </tr>
      <td >The Desperate Man</td>
      <td >The Black Keys</td>
      <td >Rubber Factory</td>
      <td >3:54</td>
      <td><a href="#">Download</a></td>
    </tr>
  </tbody>
</table>


# The Server Side Template
This is the server side template which renders a collection of songs.


```erb
<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Artist</th>
      <th>Album</th>
      <th>Time</th>
      <th>Download</th>
    </tr>
  </thead>

  <tbody>
    <% songs.each do |song| %>
      <tr>
        <td><%= song.name %></td>
        <td><%= song.artist %></td>
        <td><%= song.album %></td>
        <td><%= song.time %></td>
        <td><%= link_to "Download", song.file %></td>
      </tr>
    <% end %>
  </tbody>
</table>
```

# The Build Process

This tutorial assumes that you have access to frontend tooling for linting, compilation, concatenation, and minification. We use [lineman.js](http://linemanjs.com/) at test double for our build process and quite like it. 

# Render Dummy Data on the Client

Our first step is the Folger's challenge. We're going to move the rendering to the client without changing any functionality. Before writing any JavaScript, you'll need to pull in the angular.js library.

Add the ng-app attribute to a parent element of the table. Scope it as close as possible if you're nervous or just add it to the html tag if you don't want to think about it.
```html
<html ng-app="mixtape">
```

We're going to change that server side template into a flat HTML file with Angular markup. (A [video](http://egghead.io/lessons/angularjs-ngrepeat-and-filtering-data) on the `ng.repeat` filter)

```html
<table ng-controller="songListCtrl">
  <thead>
    <tr>
      <th>Name</th>
      <th>Artist</th>
      <th>Album</th>
      <th>Time</th>
      <th>Download</th>
    </tr>
  </thead>

  <tbody>
    <tr ng-repeat="song in songs">
      <td>{{ song.name }}</td>
      <td>{{ song.artist }}</td>
      <td>{{ song.album }}</td>
      <td>{{ song.time }}</td>
      <td><a href="{{ song.download }}">Download</a></td>
      </tr>
  </tbody>
</table>
```

We declare our angular module.

**mixtape.js**
```Javascript
angular.module("mixtape", []);
```

Add our controller. (A [video](http://egghead.io/lessons/angularjs-controllers) on controllers.)

**controllers/song_list_ctrl.js**
```javascript
angular.module("mixtape").controller("songListCtrl", function($scope) {
  return $scope.songs = app.songFixture;
});
```

A temporary fixture file so we won't have to worry about an ajax request quite yet.

**fixtures/song_fixture.js**
```Javascript
window.app = app || {};

//Temporary fixture
window.app.songFixture = [{
  name: "My Love",
  artist: "The Bird and the Bee",
  album: "Ray Guns Are Not Just The Future",
  time: "3:46",
  download: "https://example.s3.amazonaws.com/path/02_My_Love.m4a",
  url: "http://example.com/songs/1.json",
  path: "/songs/1"
},
{
  name: "Team",
  artist: "Lorde",
  album: "Pure Heroine",
  time: "3:13",
  download: "https://example.amazonaws.com/path/Lorde_-_Team__Clean_.mp3",
  url: "http://example.com/songs/30.json",
  path: "/songs/30"
}]
```

Our page should look identical other than us only displaying two songs.

# Render Real Data on the Client

It's time to pull in real data and render it. First we'll need to expose restful routes with our server side code of choice.

Here are the [routes](http://linemanjs.com/#api-integration) I'm exposing for songs.

```
GET    /songs                     songs#index
POST   /songs                     songs#create
GET    /songs/new                 songs#new
GET    /songs/:id/edit            songs#edit
GET    /songs/:id                 songs#show
PATCH  /songs/:id                 songs#update
PUT    /songs/:id                 songs#update
DELETE /songs/:id                 songs#destroy
```

Next we'll need to download and include the separate angular-resource.js to get access to the `$resource` provider. Once we have that file included in our dependencies, we'll add it to our module declaration.

**mixtape.js**
```javascript
angular.module("mixtape", ["ngResource"]);
```

Next we'll need an object that knows how to interact with those RESTful routes. (A [video](http://egghead.io/lessons/angularjs-sharing-data-between-controllers) on services.)


**models/song.js**
```javascript
// use "/songs/:id.json" in Rails.
angular.module("mixtape").factory("Song", function($resource) {
  return $resource("/songs/:id");
});
```

Point our controller at our `Song` object instead of the fixture.

**controllers/song_list_ctrl.js**
```javascript
angular.module("mixtape").controller("songListCtrl", function($scope, Song) {
  return $scope.songs = Song.query();
});
```

*Delete* **fixtures/song_fixture.js**

We're now at feature parity with the server side code. 

# Feature Request: Sort on Columns

No change to our JavaScript for this feature. ([Read](http://docs.angularjs.org/api/ng.filter:orderBy) about `ng.filter:orderBy`.)

```html
<table ng-controller="songListCtrl">
  <thead>
    <tr>
      <th><a href="" ng-click="predicate = 'name'; reverse=!reverse">Name</a></th>
      <th><a href="" ng-click="predicate = 'artist'; reverse=!reverse">Artist</a></th>
      <th><a href="" ng-click="predicate = 'album'; reverse=!reverse">Album</a></th>
      <th><a href="" ng-click="predicate = 'time'; reverse=!reverse">Time</a></th>
      <th>Download</th>
    </tr>
  </thead>

  <tbody>
    <tr ng-repeat="song in songs | orderBy:predicate:reverse">
      <td>{{ song.name }}</td>
      <td>{{ song.artist }}</td>
      <td>{{ song.album }}</td>
      <td>{{ song.time }}</td>
      <td><a href="{{ song.download }}">Download</a></td>
      </tr>
  </tbody>
</table>
```

Seriously, that's it.

# Feature Request: Filter on Input

Once again, no change to our JavaScript. ([Read](http://docs.angularjs.org/tutorial/step_03) about filtering repeaters.) Here are the changes to the HTML in isolation.
```html
Filter: <input ng-model="query">
...
    <tr ng-repeat="song in songs | orderBy:predicate:reverse | filter:query">
...
```

And the whole file.

```html
Filter: <input ng-model="query">

<table ng-controller="songListCtrl">
  <thead>
    <tr>
      <th><a href="" ng-click="predicate = 'name'; reverse=!reverse">Name</a></th>
      <th><a href="" ng-click="predicate = 'artist'; reverse=!reverse">Artist</a></th>
      <th><a href="" ng-click="predicate = 'album'; reverse=!reverse">Album</a></th>
      <th><a href="" ng-click="predicate = 'time'; reverse=!reverse">Time</a></th>
      <th>Download</th>
    </tr>
  </thead>

  <tbody>
    <tr ng-repeat="song in songs | orderBy:predicate:reverse | filter:query">
      <td>{{ song.name }}</td>
      <td>{{ song.artist }}</td>
      <td>{{ song.album }}</td>
      <td>{{ song.time }}</td>
      <td><a href="{{ song.download }}">Download</a></td>
      </tr>
  </tbody>
</table>
```

# Next: Angular Throwdown

That's it for this tutorial, but you should have the tools to add the following on your own.
* pagination
* in-place CRUD
* async, parellel file uploads

# Conclusion

The goal of this tutorial was providing a recipe for making small changes to the functionality of an app with Angular. We wanted the changes to be small to give us a place to use Angular without rewriting the existing codebase which makes it easier to get started.

