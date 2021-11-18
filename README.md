<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Inspired by [[https://pub.dev/packages/aspen][aspen]] but specified for using npm modules in
[[https://pub.dev/packages/flutter_js][flutter_js]].

## Features

- Creates a .dart file containing constants that included javascript code read from specified files
  by using `@TextAsset` annotation.

## Getting started

```
flutter pub add -d build_runner
flutter pub add -d flutter_js_asset
```

To build, type

```
flutter pub run build_runner build
```
To test, type

```
flutter pub run build_runner test
```

## Usage

1. Create a npm module in `web` folder or any other folders are whitelisted because by default
`package:build` only allows you to use assets from a pre-defined whitelist of directories.

2. Installs packages you'd like to use and
3. Create a `index.js` and exports modules to global object like this:

```javascript
module.exports.lib = require('name/of/module');
```

4. Generates a `bundle.js` by using webpack.
5. Creates a dart file like this:

```dart
library example;

import 'package:flutter_js_asset/annotations.dart';

part 'example.g.dart';

@TextAsset('asset:example/web/dist/bundle.js')
const String jsCode = $jsCodeContent;
```

6. Generates $jsCodeContent by typing:

```sh
flutter pub run build_runner build
```

see `example` for more details.
