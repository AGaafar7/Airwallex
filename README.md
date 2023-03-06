# Airwallex

[![pub package](https://img.shields.io/pub/v/airwallex.svg)]
(<https://pub.dartlang.org/packages/airwallex>)

A plugin to deal with Airwallex platform on Flutter applications.

## Platform Support

This plugin supports Android and ios. Windows, linux ,and macos will be available soon.

### Getting started

Before you start, create an account on Airwallex platform. To create an airwallex account follow this link.
<https://www.airwallex.com/signup>

#### Usage

To start using this plugin, add `airwallex` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/):

```yaml
dependencies:
  airwallex: ^0.0.2
  ```

After you add this plugin you will need to initialize the plugin using the code block below:

```dart
 Airwallex _airwallex = Airwallex();
  await _airwallex.initialize(
    true,
    "DEMO",
    ["CARD", "REDIRECT"],
  );
```

After you initialized the plugin you will need to login to get your token to be able to use the plugin functionality to do that use the code below:

```dart
  await _airwallex.login(
        "Your-API-key",
        "Your-ClientId",
      );
```
