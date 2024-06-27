# Wame Sports Challenge

> The challenge involves creating a Flutter application that consumes a REST API to fetch and
> display data on the screen.

> The first thing you should do is select one of your choice (you have a
> wide variety available at https://rapidapi.com/). Choose one that effectively showcases your
> skills. The selected API must be accessible for free, although it is OK if it requires registration.

For my use case, I will choose [GeoDB Cities](https://rapidapi.com/wirefreethought/api/geodb-cities). This API has a free tier which, at the moment of the creation, I intend to display a list of all the countries in the main screen, each element displayed will redirect to a detailed screen with additional information.

The state management and separation of concerns is addressed by following BLoC pattern. Also, since it is intended to achieve a successful implementation of data persistence, the strategy therefore is leveraging the use of _Hydrated BLoC_ library.

## Submission Criteria

> Your project must meet the following criteria:
>
> - [ ] Developed using Flutter, it should be operable on mobile devices, ideally on both Android
>       and iOS. If access is limited to one of these platforms, then it should work on the one
>       available.
> - [ ] Upon launch, the app must display a list of items fetched from the API. Selecting an item should open a detail screen showing more information about it.

## Evaluation

> The following aspects of your submission will be assessed:
>
> - [ ] Efficiency in utilizing the remote API, including the application of good methodologies and best practices in data management. An optional cache system for data persistence will be highly regarded.
> - [ ] The application of best practices, clean architecture, and SOLID principles in your solution.
> - [ ] State management in the user interface. Use the approach you are most comfortable with,
>       ensuring a clear distinction between state management and visual presentation.
> - [ ] The quality of the code documentation and the inclusion of a README.md file that
>       provides relevant information about the project. If the project is delivered through a GIT
>       repository, the organization of commits will also be evaluated.
