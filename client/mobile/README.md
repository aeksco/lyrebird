# Lyrebird Mobile Application

**Built with:**

- [Cordova](https://cordova.apache.org/)

- [CoffeeScript](http://coffeescript.org/)

- [Jade](http://jade-lang.com/)

- [SASS](http://sass-lang.com/)

- [BS4 (Alpha)](http://v4-alpha.getbootstrap.com/)

- [Font-Awesome](http://fortawesome.github.io/Font-Awesome/icons/)

- [Underscore.js](http://underscorejs.org/)

- [Backbone.js](http://backbonejs.org/)

- [Marionette.js](http://marionettejs.com/)

- [Codo](https://github.com/coffeedoc/codo) (Documentation generation)

#### Building the App
- ```npm install -g gulp```
- ```npm install -g cordova```
- ```npm install```
- ```gulp```

#### Deploying the App
- ```cordova run android --device```

## Directory Structure
- **app/** --- client application
- **platforms/** --- Cordova platforms
- **plugins/** --- Cordova plugins
- **Gulpfile.coffee** --- build configuration
- **package.json** --- dependency management
- **config.xml** --- Cordova configuration

##### app/

- **img/** - Images (only stores logo.png)
- **sass/** --- SASS & style dependencies
- **coffee/** --- CoffeeScript source files

##### app/coffee
- **behaviors/** --- Behaviors
- **components/** --- Components
- **config/** --- Configuration files
- **modules/** --- Modules
- **services/** --- Services
- **app.coffee** --- Application manifest
- **cordova_app.coffee** --- Application class

##### app/coffee/behaviors
###### Behaviors are view mixins used in both Components and Modules.

##### app/coffee/components
###### Components are routeless services with views that are accessible anywhere in the application.

  - **component_name**/ --- Each Component in a separate directory
    - **component.coffee** --- Component controller
    - **views/** --- Component views
      - **layout.coffee**
      - **templates/** --- Component templates
        - **component.jade**

##### app/coffee/config
###### Configuration files for Marionette.js, and whatever else needs configuration.

##### app/coffee/modules
###### Modules represent collections of endpoints in the application. They always have a Router and at least one Route, and often have Models, Collections, and Services.

###### NOTE: The complexity of directory structure in Modules and Components may seem redundant, but the opinions enforced by this structure work effectively to ensure scalability of the application from a development perspective.

  - **module_name**/ --- Each Module in a separate directory
    - **route_01/**
      - **views/** --- Route views
        - **layout.coffee**
        - **templates/** --- Route templates
          - **module.jade**
    - **route_02/**
    - **.../** --- (modules can have many routes)
    - **collection.coffee** --- Backbone.Collection
    - **model.coffee** --- Backbone.Model
    - **router.coffee** --- Router
    - **service.coffee** --- Service

##### app/coffee/services
###### Services are workers that are available to perform specific background tasks. They are _routeless_, and they neither maintain nor manage any views.
