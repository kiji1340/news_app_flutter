# News App Flutter

news_app_flutter is my Flutter project example that is based on Clean Architecture.
## Project Structure
![](https://github.com/kiji1340/news_app_flutter/blob/main/gif/project_structure.png)

the ***config*** includes the configuration of the app.

the ***utils*** contains constants, extensions, resources...

the ***data*** layer is in charge of combining 1 or multiple data source. The most common are Memory, Cache, and Remote.

the ***domain*** layer, which is the most important layer, contains the core business logic.

the ***presentation*** is a layer responsible for handling the user interface and user interaction.


![](https://github.com/kiji1340/news_app_flutter/blob/main/gif/clean_architect_structure.png)


like a diagram describes:

The ***Presentation*** layer, I use bloc that helps manage state and event from UI and it only communicates with the ***Domain*** layer via Repositories.

The ***Domain*** layer just gets and sends data via repositories of the ***Data*** layer.

The ***Data*** layer, it can has many ways to handle data but it does not effect to the Domain layer.

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

I use Mockito to test the ***Domain*** and ***Data***

here is example

```dart
      when(api.getBreakingNewsArticles(
        apiKey: request.apiKey,
        country: request.country,
        category: request.category,
        page: request.page,
        pageSize: request.pageSize,
      )).thenAnswer((_) async => HttpResponse<BreakingNewsResponse>(
          response,
          Response(
            data: 'response json',
            statusCode: HttpStatus.unauthorized,
            requestOptions: RequestOptions(path: ''),
          )));
      final result =
      await apiRepositoryImpl.getBreakingNewsArticles(request: request);
      expect(result, isInstanceOf<DataFailed>());
```

and use bloc_test to test the ***Presentation***

```dart
    blocTest<RemoteArticlesCubit, RemoteArticlesState>(
      "Test RemoteArticlesCubit success",
      setUp: () {
        when(apiRepository.getBreakingNewsArticles(request: request))
            .thenAnswer((_) => Future.value(DataSuccess(response)));
        cubit = RemoteArticlesCubit(apiRepository);
      },
      build: () {
        return cubit;
      },
      act: (cubit) async {
        cubit.getBreakingNewsArticles(request: request);
      },
      expect: () => [isInstanceOf<RemoteArticlesSuccess>()],
    );
```

this is a result after the unit test but it has not been completed and I continue to write the unit test to cover it.

![](https://github.com/kiji1340/news_app_flutter/blob/main/gif/unit_test.png)

## How to run

First of all, let you command in your terminal to get all library.

```
flutter pub get
```

This project use [News API](https://newsapi.org/docs/get-started). If you don't have let's create a new one. After that, you add your key into 
```dart
const String kApiKey = "";
```
2 values in file strings.dart(lib/src/utils/constants/strings.dart) and done

![](https://github.com/kiji1340/news_app_flutter/blob/main/gif/ezgif-4-0e6276ed72.gif)

## I learned from where

I learn clean architecture from this [article](https://devmuaz.medium.com/flutter-clean-architecture-series-part-1-d2d4c2e75c47)
