# RichFlights-2.0
Flight ticket price and progress tracking

## Motivation
This project is an update for a class project I did back in college ([original college project repo](https://github.com/masterstoney/richsflights)). I wanted to see what the project would be like in a world where SwiftUI, Combine, Diffable Datasource and Widgets exist. Admittedly, I only ended up using SwiftUI for a widget view and a single detailed view (my love for UIKit is still very strong). I also wanted to add a feature to track the progress of flights which is a feature that was not available in the original application.

## Screenshots
<p align="center">
  <img src="Screenshots/homeScreen.PNG" alt="Home screen" width="375" height="812">
  <img src="Screenshots/emptyTripSelectionView.PNG" alt="Empty trip selection view" width="375" height="812">
  <img src="Screenshots/airportSelectionView.PNG" alt="Route selection view" width="375" height="812">
  <img src="Screenshots/TripSelectionView.PNG" alt="Trip selection view with New York to Los Angeles trip" width="375" height="812">
  <img src="Screenshots/searchResult.PNG" alt="Results of JFK-LAX trip search" width="375" height="812">
  <img src="Screenshots/flightTrackingSearchView.PNG" alt="Flight tracking search view" width="375" height="812">
  <img src="Screenshots/flightTrackDetailedView.PNG" alt="Detail view for tracked flight AA123" width="375" height="812">
</p>

## Build settings

Application was built to run on devices with iOS 14 or higher.

## Architecture

Application was built using MVC with a bit of Reactive Programming sprinkled in there. Combine was not available back when I made the first version of the application. Using it in conjuction with diffable datasource made the process of coming up with a search [pipeline](https://github.com/masterstoney/RichFlights-2.0/blob/f7e08b8a3083840fcf40f913304990396072ec4c/RichFlights%202.0/Controller/AirportSelectionViewController.swift#L161) super easy.

## Tech and frameworks

All programming was done in Swift. The user interface was mostly built programmatically using UIKit and some other parts were built using SwiftUI. The loading animation shown below was built using CoreAnimation. As stated above, the application also takes advantage of Combine. The application uses SQLite to store the airports list. The database connection and some of the data models were taken as they were from the original application and plugged into this version. I only had to make minor adjustments to cater for changes in APIs.

<p align="center">
  <img src="Screenshots/loadingAnimation.gif" alt="Loading Animation" width="375" height="812">
</p>

## What's new in this version?

The application now enables users to track flights. All the user has to do is enter the IATA flight code and they should be able to get the information about the flight. This functionality is shown in one of the screenshots above. The user can take advantage of Widgets and keep track of the flight progress from their home screen. Due to API limits, widget functionality is turned off for now.

<p align="center">
  <img src="Screenshots/WidgetConfiguration.PNG" alt="Loading Animation" width="375" height="812">
  <img src="Screenshots/WidgetSmall.PNG" alt="Loading Animation" width="375" height="812">
</p>

