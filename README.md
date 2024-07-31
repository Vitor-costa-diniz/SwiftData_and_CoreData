# Swift Project with SwiftData and Core Data

This project demonstrates how to use two data persistence frameworks, SwiftData and Core Data, within a SwiftUI application. The project follows the MVVM (Model-View-ViewModel) architecture and implements the Repository pattern to facilitate switching between the data persistence frameworks.

## Objective

To showcase how to organize a project using multiple data persistence frameworks, leveraging the Repository pattern to abstract data access and allow for flexible switching between technologies.

## Project Branches

The project is organized into four main branches:

1. **main**: The main branch that integrates both frameworks (SwiftData and Core Data) using the Repository pattern, allowing for switching between them.
2. **SwiftData**: Basic implementation using only SwiftData.
3. **SwiftDataRepository**: Implementation of SwiftData with the Repository pattern.
4. **CoreData**: Implementation using Core Data, adapted to the Repository pattern.

## Switching Between SwiftData and Core Data

A key feature of this project is the ability to switch between SwiftData and Core Data using the Repository pattern. This is achieved through a common implementation of the repository interface, which encapsulates the data access logic for each framework, making the technology switch transparent to the rest of the application.

## Unit Tests

The project includes unit tests to ensure the correct functionality of CRUD (Create, Read, Update, Delete) operations with both SwiftData and Core Data. These tests verify that the logic for switching between frameworks works as expected.

