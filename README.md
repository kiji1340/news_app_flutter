# News App Flutter

news_app_flutter is a Flutter project example that is based on Clean Architecture.
## Project Structure
![](https://github.com/kiji1340/news_app_flutter/blob/main/gif/project_structure.png)

the ***config*** includes the configaruation about the app.

the ***utils*** contains constants, extensions, resources...

the ***data*** layer is one layer of Clean Architecture. It is in charge of combining 1 or multiple data source. The most common are Memory, Cache, and Remote.

## Libraries

| Library | Description |
| --- | --- |
| retrofit | is library that works with **REST API**, it’s inspired by the Android Retrofit. |
| floor | is libaray that works with **SQLite** and its structure like **Android ROOM** |
| equatable | helps to compare Dart object|
| get_it | is a simple service locator |
| flutter_hooks | helps to manage the life-cycle of a widget |
| auto_route | use it instead of default Navigator |
| lint | helps to write clean code |
| flutter_bloc | helps to manage state |


## Unit Test
| Library | Description |
| --- | --- |
| mockito | helps to mock data object|
| bloc_test | helps to test bloc |

## How to run

This project use [News API](https://newsapi.org/docs/get-started). If you don't have let's create a new one. After that, you add your key into 
```dart
const String kApiKey = "";
```
2 values in file strings.dart(lib/src/utils/constants/strings.dart) and done

![](https://github.com/kiji1340/news_app_flutter/blob/main/gif/ezgif-4-0e6276ed72.gif)

