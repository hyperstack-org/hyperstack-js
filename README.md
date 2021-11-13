#  Hyperstack

This fork fix Gemfile, and hyperstack-compiler in order to get latest hyperstack (1.0.alpha1.8) and opal (1.3.2)

### Hyperstack.js

Hyperstack client-side including:

+ Hyperstack Components
+ Hyperstack Stores
+ Hyperstack Operations
+ Opal Active Support, Opal JQuery

Note: React, ReactDOM, createReactClass, ReactRailsUJS and JQuery are not included. You will need to provide these.

### Hyperstack-compiler.js

Compiles code in your browser. Client-side Hyperstack and Opal for static sites or fast prototyping, with no backend or build process needed.

+ Ruby code in your HTML pages is compiled into JavaScript on page load
+ You can work with Hyperstack Components, Stores, Operations and HyperRouter
+ No backend dependency or setup required

### Hyper-router.js

Ruby DSL wrapper of React Router V4. Requires ReactRouter, ReactRouterDOM and History.

## Documentation and Help

+ Please see the [Hyperstack](https://docs.hyperstack.org/) website for documentation
+ [Join](https://join.slack.com/t/hyperstack-org/shared_invite/enQtNTg4NTI5NzQyNTYyLWQ4YTZlMGU0OGIxMDQzZGIxMjNlOGY5MjRhOTdlMWUzZWYyMTMzYWJkNTZmZDRhMDEzODA0NWRkMDM4MjdmNDE) our Slack group for help and support

See [VERSIONS](https://github.com/hyperstack-org/hyperstack/blob/master/VERSIONS.md) for the version numbers of the included Gems.

## How it works

##### Front-end

+ Hyperstack.js includes Hyperstack's client side Components, Operations and Stores.
+ Hyperstack-compiler.js includes Opal Compiler for compiling Ruby Hyperstack code in your browser.
+ Hyper-router includes a client-side build of the Hyper-router gem

##### No back-end (compile Ruby code in your browser)

If you do not want a backend then you can use Hyperstack-compiler.js to compile code in your browser. Your ruby code will be compiled by the browser into JavaScript and executed.  Any compilation or runtime errors will be briefly reported to the console.


##### Back-end (compile Ruby code on the server)

To compile your code server-side, you will need a backend integrated with Opal. Your choices are:

+ Hyperstack Gem for Rails integration (including Isomprphic Models & Operations)
+ Opal Sprockets for Rack backend for a simple build process
+ Minimal Rake task to compile with Opal
+ Node.js using Webpack to compile Opal code

See all the installation options on https://docs.hyperstack.org/installation

## How to use

### Hyperstack Components, Operations, Stores, and Router

The simplest way to install is with NPM.

```
npm install hyperstack-js --save
```

Then include the libraries in your Webpack script:

```javascript
// following needed before hyperstack-js
ReactDOM = require('react-dom');
React = require('react');
createReactClass = require('create-react-class');
ReactRailsUJS = require('react_ujs')

// following needed before hyper-router (if you are using ReactRouter)
ReactRouter = require('react-router');
ReactRouterDOM = require('react-router-dom');
History = require('history');

// Jquery and Opal
$ = require("jquery");
require('hyperstack-js/dist/opal');

// Hyperstack Components, Stores and Operations
require('hyperstack-js/dist/hyperstack');

// Hyper-router if you are using ReactRouter
require('hyperstack-js/dist/hyper-router');
```

If you are not using NPM/Webpack then you will need to bring in Hyperstack-JS in your HTML page:

```html
<head>
  <!-- React and JQuery (or bring your own) -->
  <script src="https://unpkg.com/react@16.8.6/umd/react.production.min.js"></script>
  <script src="https://unpkg.com/react-dom@16.8.6/umd/react-dom.production.min.js"></script>
  <script src="https://unpkg.com/create-react-class@15.6.3/create-react-class.min.js"></script>
  <script src="https://unpkg.com/react_ujs@2.6.0/react_ujs/dist/react_ujs.js"></script>
  <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>

  <!-- React Router (if you are using it) -->
  <script src="https://unpkg.com/react-router@4.3.1/umd/react-router.min.js"></script>
  <script src="https://unpkg.com/react-router-dom@4.3.1/umd/react-router-dom.min.js"></script>
  <script src="https://unpkg.com/history@4.10.1/umd/history.min.js"></script>

  <!-- Opal (or bring your own) -->
  <script src="https://rawgit.com/hyperstack-org/hyperstack-js/master/dist/opal.min.js"></script>

  <!-- Hyperstack-js -->
  <script src="https://rawgit.com/hyperstack-org/hyperstack-js/master/dist/hyperstack.min.js"></script>

  <!-- Hyper-router.js (if you are using React Router) -->
  <script src="https://rawgit.com/hyperstack-org/hyperstack-js/master/dist/hyper-router.min.js"></script>
</head>
```

**That is all you need for Hyperstack Components, Stores, Operations and Router client-side. If you have a back-end building Hyperstack code you are good to go!**

### Hyperstack Compiler

If you do not have a back-end and you want to compile your Hyperstack code in your browser then follow this step.

#### Setup

After completing the steps above, add the following to your Webpack script:

```javascript
require('hyperstack-js/dist/hyperstack-compiler');
```

Or add the following to your HTML page:

```html
<head>
  <!-- Hyperstack-compiler (only needed if you are doing in browser compiling) -->
  <script src="https://rawgit.com/hyperstack-org/hyperstack-js/master/dist/hyperstack-compiler.min.js"></script>
</head>
```

#### Usage

Specify your ruby code inside script tags or link to your ruby code using the src attribute `<script type="text/ruby" src=.../>`

```html
<head>
  <script type="text/ruby">...</script>
</head>
```

Finally, mount your Component(s) as a DOM element and specify the Component and parameters using data- tags:

```html
<body>
  <div data-hyperstack-mount="SayHello"
       data-name="World">
  </div>
</body>
```
Note: For a Single Page Application (SPA) you would only mount your first (top-level) Component and that would render all subsequent Components.

#### Example

Here is a simple index.html:
```ruby
<!DOCTYPE html>
<!--[if IE]><![endif]-->
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Hyperstack-JS Demo</title>

    <!-- React and JQuery -->
    <script src="https://unpkg.com/react@16.8.6/umd/react.production.min.js"></script>
    <script src="https://unpkg.com/react-dom@16.8.6/umd/react-dom.production.min.js"></script>
    <script src="https://unpkg.com/create-react-class@15.6.3/create-react-class.min.js"></script>
    <script src="https://unpkg.com/react_ujs@2.6.0/react_ujs/dist/react_ujs.js"></script>
    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>

    <!-- Opal (or bring your own) -->
    <script src="dist/opal.min.js"></script>

    <!--Hyperstack -->
    <script src="dist/hyperstack.min.js"></script>
    <script src="dist/hyperstack-compiler.min.js"></script>

    <script type="text/ruby">
      class SimpleComponent < Hyperstack::Component
        render(DIV) do
          BUTTON { 'Push the button' }.on(:click) do
           alert 'You did it!'
          end
        end
      end
    </script>
  </head>

  <body>
  <div data-hyperstack-mount="SimpleComponent">
  </div>
  </body>
</html>
```

Copy the code above into an `index.html` file and launch a simple web server with `ruby -run -e httpd . -p 8000` (or if you prefer Python) `python -m SimpleHTTPServer` then navigate to  http://localhost:8000/

#### Want a larger example?

The [Hyperstack website](https://docs.hyperstack.org/tutorial)

#### Trying it out using GitHub

Github makes a great sandbox to try out small Hyperstack online with nothing but your browser.

Have a look at the instructions here: https://pages.github.com/

Rather than "cloning" the repo, and editing your files on your computer you can just create and edit files right on the GitHub site.

#### Mounting Components

hyperstack-js will directly mount components onto DOM elements that have the `data-hyperstack-mount` attribute.  The attribute value should be the fully qualified name of the component.  For example "MyComponent".  Any additional data attributes will be passed as params to the component.  The attribute names will be snake cased (i.e. `data-foo-bar` becomes the `foo_bar` key)

## Building and Contributing

To build, clone the repo, run `bundle install` and then `bundle exec rake`

This will combine all the pieces and build `hyperstack.js`, `hyperstack-compiler.js`, `hyper-router.js`, and `opal.js`.

Publish to NPM `npm publish`

Contributions are most welcome!
