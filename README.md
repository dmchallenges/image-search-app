# Flickr API Exercise

## Overview

Overall the goal was to keep the project simple and extensible. 

#### API
The Flickr api implementation is hidden behind two protocols (Photo and PhotoService), so switching to a different API would not affect the other parts of the app. 

#### Images
The ImageProvider class downloads and cache images on a NSCache object for a given URL.

#### UI
PhotoSearchViewController implements the CollectionView and uses the PhotoService to fetch Photos.

#### Tests
The APIClient protocol is a simple wrapper for network requests that helps mocking the network requests on the unit tests.


## Some shortcuts taken
For simplicity and time management reasons, some shortcuts were taken. In this section I'll try to briefly list them.

#### Error handling and retrying
- No UI for presenting errors.
- No retries on image loading errors.

#### Search state
- Search service does not consider the number of pages available to a given search string.
- There's no specific event for search without results. 

#### Testability of UI states
- Extracting the state logic from PhotoSearchViewController to a ViewModel for example would make testing easier.
