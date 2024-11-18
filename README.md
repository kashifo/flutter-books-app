# flutter_books_app

Flutter hobby project to List, Search, View details, Favorite and Read books from Google Books API.

### Features:
- Login/Signup with Firebase
- View random books - Discover screen
- Search books
- View favorite books
- Save favorites on Firebase
- Read using WebView

### Upcoming Features:
1. Clean Architecture
2. Bloc State Management
3. Pagination
4. New UI for book detail screen - almost completed


### Mobile Screenshots:
| ![login_app.jpg](screenshots%2Fdiscover_app.jpg) | ![discover_app.jpg](screenshots%2Fsearch_app.jpg) | ![favorites_app.jpg](screenshots%2Ffavorites_app.jpg) |
|---|---|---|

### Desktop Screenshots:
![discover.png](screenshots%2Fdiscover.png)
![search.png](screenshots%2Fsearch.png)
![favorites.png](screenshots%2Ffavorites.png)
![book_detail.png](screenshots%2Fbook_detail.png)

### Build Instructions:
1. Edit run configuration, in the additional run args use the below line
```
--dart-define-from-file="lib/api_keys.json"
```
2. Create a file named api_keys.json in lib folder and add your API keys
```
   {
   "FIREBASE_KEY": "",
   "GOOGLE_BOOKS_API_KEY": "",
   "FIREBASE_PROJECT_ID": ""
   }
```

### Disclaimer:
Code upgrade to latest standards will be done soon, for now it's just a hobby/time-killer/leisure project.
