# Movie App Documentation

## Overview
This project uses `https://developer.themoviedb.org/` to achieve a simple movie search application

## How to run
1. Clone the project
2. Open it using Xcode (The project built with Xcode 15.4 with minimum target of iOS 16.0)

Note that no other tools are needed to run the app.

## Architecture
The main used architecture is `MVVMR`
The view sends actions to viewModel and ViewModel state changes based on actions and available data, as the view observes the viewModel state, the view will change based on state changes.

### DI
The app is using Context for DI, a context injected to the first module, and this module's router injects the context to other modules on initialization

## Localization
Currently, the app supports Farsi and English languages and the language can changed from the settings. Also, search result language changes based on the app's current language.

## Theme
The app supports light and dark themes with the initial value of dark theme at the start of the app.

## External Libraries
The only used external dependency is `KingFisher` for loading remote images.
This helped me from developing the whole image loading logic.

## Enhancement List
the following list isn't implemented in the app, but we can make this project better by implementing it:
- [ ] Impelenting UseCases
- [ ] Modularization
- [ ] Instead of using `Locale.current.language` directly, it can used as a service that injects to ViewModel in this case so we can test this logic as well.
