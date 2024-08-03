# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Usage](#usage)
4. [Arhitecture](#arhitecture)
5. [Structure](#structure)
6. [Running the tests](#running-the-tests)
7. [Deployment](#deployment)
8. [Dependencies](#dependencies)
9. [Workflow](#workflow)

# ToDoSwiftUI Demo App

<br />
<p align="center">
  <a href="https://github.com/marcelomogrovejo/todo-swiftui/">
    <img src="logo-to-do-list.png" alt="Logo" width="80" height="80">
  </a>
  <p align="center">
    A simple project that handle user tasks
  </p>
</p>

# Description
<p>ToDoSwiftUI project is a very simple app which is developed to learn and compare Swift and SwiftUI capabilities.<br>
The project consists of a simple list of tasks which the user can delete, edit and create.</p>

# Getting started
<p>
1. Make sure you have the Xcode version 14.0 or above installed on your computer.<br>
2. Download the ToDoSwiftUI project files from the repository.<br>
3. Open the project files in Xcode.<br>
4. Make sure the TodoRepositoryPackage, PetShopAnimationPackage and Lottie Swift Packages are downloaded successfully.<br>
5. Run the active scheme.<br>

You should see a lottie animation on the screen.<br>
You should see a main button that takes you to an empty list of tasks.<br>

# Usage
In order to start managing tasks, you should tap on the main button, which will take you to an empty task list.<br>
There you can add new tasks by tapping the plus button "+" on the top right of the screen.<br>
Once the new task is added you can see it on the list.<br>
In order to edit an existing task you should swipe left the task item on the list and tap the "Edit" button.<br>
In order to delete a task you should swipe left the task item on the list and tap the "Delete" button.<br>

# Architecture
* ToDoSwiftUI project is implemented using the <strong>Model-View-ViewModel (MVVM)</strong> architecture pattern.

* Model has any necessary data structure needed to generate the task.
* ViewModel
* View is responsible for displaying the task form to be filled by the user.

* Controller handles any user input or interactions and update the Model and View as needed.
* Project doesn't have a local database.<br><br>

# Structure 
* "Resources": Non-code files that are needed across the project. Sush as images, animations, adio files, and other types of assets.
* "Extension": Extensions that are needed across multiple sections of the project. Such as date to string converters, ui extensions, among others..
* "Assets": Image files that are used by the project. This includes a uiimage extension that helps to include those images into the app without depending on the file names. 
* "ColorPalette": Color scheme assets used by the project. This includes a uicolor extension that helps to include those into the app without depending on the names.
* "Scene": Main folder of the app that includes the sections. Such as Task, List and Main. Each one has the same structure such as View, Model, Presenter, Factory, Router among others.

# Running the tests
<p>The ToDoSwiftUI project can be tested using the built-in framework XCTest.<br>
To start testing the project, you will need to change to the 'ToDoSwiftUITests' target in your Xcode project, and then just run the tests project.</p>

# Deployment
Keep in mind that deploying an iOS app to the App Store requires having an Apple Developer account.

1. Click on the "Product" menu in Xcode and select "Archive." This will create an archive of your project.
2. Once the archive has been created, select it in the Organizer window and click on the "Validate" button to perform some preliminary tests on the app.
3. Once validation is complete, click on the "Distribute" button and select "Ad Hoc" or "App Store" distribution. 
This will create a signed IPA file that can be installed on iOS devices.
4. Follow the prompts in the distribution wizard to complete the distribution process.
5. Once the distribution is complete, you can use the IPA file to install the app on iOS devices

# Dependencies
[Swift Package Manager (SPM)](https://www.swift.org/documentation/package-manager/) is used as a dependency manager.
List of dependencies: 
* [Lottie package](https://lottiefiles.com/) -> Lightweight Lottie animations.
* [PetShopAnimationPackage](https://gitlab.com/marcelomogrovejo/petshopanimationpackage) -> Our library that serves the Lottie animagion common implementation.
* [TodoRepositoryPackage](https://github.com/marcelomogrovejo/todo-repo-pkg) -> Our <strong>common</strong> library that serves the persistence layer. 

# Workflow

* Reporting bugs:<br> 
If you come across any issues while using the ToDoSwiftUI app, please report them by creating a new issue on the GitHub repository.

* Reporting bugs form: <br> 
```
App version: 1.02
iOS version: 16.1
Description: When I tap on the "Cancel" button, the add task screen doen's close.
Steps to reproduce: On the add new task screen, by tapping the "Cancel" button on the top left of the screen, the screen doesn't close and navigate back to the list screen.
```

* Submitting pull requests: <br> 
If you have a bug fix or a new feature you'd like to add, please submit a pull request. Before submitting a pull request, 
please make sure that your changes are well-tested and that your code adheres to the Swift style guide.

* Improving documentation: <br> 
If you notice any errors or areas of improvement in the documentation, feel free to submit a pull request with your changes.

* Providing feedback:<br> 
If you have any feedback or suggestions for the ToDoSwiftUI project, please let us know by creating a new issue or by sending an email to the project maintainer.
