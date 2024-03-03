# Swift + SwiftUI app that allows searching GitHub users
## TechStack
Architecture: MVVM.  
Tech Stack: Swift, SwiftUI, SwiftData, Combine, async/await.

## Details
- Used several patterns which provide abstraction over Data and Model layer in the app. It allows us to easily test and substitute every part of the application.
  - Repository (abstracts getting and saving data). Could be hidden under the protocol but I decided to go without it for the simplicity.
  - DataProvider (abstracts actual implementation of how data fetched). See `protocol UserDetailsProviding` implemented by `HTTPUserDetailsProvider`.
  - DataStore (abstracts actual implementation of how data stored). See `protocol UserDetailsStoring` implemented by `DBUserDetailsStore`.
- UI models separated from DB Models. Naming for data models `nnnModel`.  Naming for DB models `nnnObject`.
- Implemented caching of the search result and user details.  
- User Details Screen loads data from cache first and then from network. User Search always uses data from network.  

## Modularisation
Project could be easily converted to multi-module application because the code is already structured applying **Dependency Rule** and **Clean Architecture Principles** [1].  
Possible structure of modules, from high-level to low-level where dependencies pointed **strictly** inwards:  
App -> SearchFeature -> Data -> Domain

## Out of Scope
- Error handling.
- Fancy UI.
- Tests.
- Fancy commit structure.
- Older iOS Versions.

Sources: 
1. [Clean Architecture. The Dependency Rule](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
