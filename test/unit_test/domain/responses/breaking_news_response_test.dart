import 'package:clean_architecture_flutter/src/domain/models/responses/breaking_news_response.dart';
import 'package:flutter_test/flutter_test.dart';

class MockBreakingNewsResponse{
  BreakingNewsResponse mockData(){
    Map<String, dynamic> json = {
      "status": "ok",
      "totalResults": 37,
      "articles": [
        {
          "source": {
            "id": "espn",
            "name": "ESPN"
          },
          "author": null,
          "title": "Legislation sets 380M price from Nevada to build A's stadium - ESPN - ESPN",
          "description": "A bill introduced in the Nevada Legislature would give the Athletics up to 380 million for a potential 30,000-seat, 1.5 billion retractable-roof stadium on the Las Vegas Strip.",
          "url": "https://www.espn.com/mlb/story/_/id/37739809/legislation-sets-380m-price-nevada-build-stadium",
          "urlToImage": "https://a1.espncdn.com/combiner/i?img=%2Fphoto%2F2023%2F0526%2Fr1178630_1296x729_16%2D9.jpg",
          "publishedAt": "2023-05-27T13:32:22Z",
          "content": "May 27, 2023, 09:27 AM ET\r\nCARSON CITY, Nev. -- A bill introduced late Friday in the Nevada Legislature would give the Oakland Athletics up to 380 million for a potential 30,000-seat, 1.5 billion r… [+2949 chars]"
        },
        {
          "source": {
            "id": "financial-times",
            "name": "Financial Times"
          },
          "author": "James Politi, Aime Williams",
          "title": "US debt ceiling deadline pushed back as talks continue - Financial Times",
          "description": "News, analysis and comment from the Financial Times, the worldʼs leading global business publication",
          "url": "https://www.ft.com/content/9038ed1b-ecd8-46f9-adb0-06416e10add1",
          "urlToImage": null,
          "publishedAt": "2023-05-27T13:06:52Z",
          "content": "What is included in my trial?\r\nDuring your trial you will have complete digital access to FT.com with everything in both of our Standard Digital and Premium Digital packages.\r\nStandard Digital includ… [+1494 chars]"
        }
      ]
    };

    return BreakingNewsResponse.fromMap(json);
  }
}

void main(){
  test("Test map json to object", (){
    BreakingNewsResponse response = MockBreakingNewsResponse().mockData();
    expect(response, isInstanceOf<BreakingNewsResponse>());
  });
}