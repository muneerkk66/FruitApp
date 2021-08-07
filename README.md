# FruitApp - A Fruit App is written in Swift

## Features

* List of available Fruits details. 

## Requirements

*  iOS 13.0+ / macOS 10.14.4 **Xcode 11+ **Swift 5+

## Architecture

** We have used MVVM Architecture. Model–view–viewmodel (MVVM) is a software architectural pattern. MVVM facilitates a separation of development of the graphical user interface – be it via a markup language or GUI code – from development of the business logic or back-end logic (the data model).

###  Incorporated Solid Principle 

## Components

### ViewController

FruitTableViewController Show's the list of the fruits using the Data given from the server. All the data is given by FruitVM.

FruitDetailsViewController Show's the detailed price and the weight of the selected fruit from the list

ViewModel interacts with model and also prepares observable(s) that can be observed by a View. One of the important implementation strategies of this layer is to decouple it from the View, i.e, ViewModel should not be aware about the view who is interacting with.

### Get Started
Go to project directory
Open project Workspace then run the code.
