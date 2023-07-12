#  Dessert Recipes

## Description

Dessert Recipes is a native iOS application that leverages TheMealDB, a Free Meal API to display a 
list of dessert recipes. It is designed to showcase what the dessert looks like, the instructions to make it, 
and the ingredients required.

![](https://github.com/rzheng2019/DessertRecipes/blob/main/DessertRecipesGif.gif)

## Getting Started

1. Make sure to have XCode Version 14.3.1 or above installed on your computer.
2. Open the project files in XCode.
3. (Optional) Build and run unit tests (Unit tests only seem to be working on iPhone 14 versions at the moment).
4. Build and run project (preferably on iPhone 14 versions).

## Architecture

- Dessert Recipes was implemented using Model View View-Model (MVVM) archiecture.

## Structure

- "Models": Files that contain the models for what a meal consists of.
- "ViewModels": Files that contain the view models that provide data and functionality to be used by views.
- "Views": Files that use view models to display user interface with data.
- "URLValidationTest": Unit tests that check the validity of the URLs from the API.

## Running Unit Tests

This project contains unit tests that use the built-in XCTest. These tests serve to ensure the URL links
from the TheMealDB website are valid for data accessing and JSON decoding.

## API

- TheMealDB (Free Meal API): https://www.themealdb.com/api.php
- Two Endpoints 
    - Fetching list of desserts: https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
    - Fetching details of desserts: https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID

