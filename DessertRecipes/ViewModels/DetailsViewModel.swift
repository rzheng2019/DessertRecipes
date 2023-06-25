//
//  DetailViewModel.swift
//  DessertRecipes
//
//  Created by Ricky Zheng on 6/24/23.
//

import Foundation

// Create a another viewmodel for individual meal api endpoint
class DetailsViewModel: ObservableObject {
    @Published var detailedMeals: DetailedMeals = DetailedMeals(meals: [])
    @Published var displayViewModel: DisplayViewModel = DisplayViewModel()
    
    // API Endpoint to Retrieve Details of Dessert
    func fetch(idMeal: String) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
            return
        }
        
        let apiCall = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let detailedMeals = try JSONDecoder().decode(DetailedMeals.self, from: data)
                DispatchQueue.main.async {
                    self?.detailedMeals = detailedMeals
                    if let dessert = detailedMeals.meals.first {
                        if let dessertDetails = self?.filterDesserts(detailedMeal: dessert) {
                            self?.displayViewModel = dessertDetails
                        }
                    }
                }
            }
            catch {
                print(error)
            }
        }
        
        apiCall.resume()
    }
    
    func filterDesserts(detailedMeal: DetailedMeal) -> DisplayViewModel {
        var dessertDisplayModel: DisplayViewModel = DisplayViewModel()
        
        let mirror = Mirror(reflecting: detailedMeal)
//        print(detailedMeal)
        
        // Filtered out null and empty values
        for child in mirror.children {
            if let value = child.value as? String,
               let label = child.label {
                if value != "" && value != " "
                {
                    switch label {
                    case "idMeal":
                        dessertDisplayModel.idMeal = value
                    case "strMeal":
                        dessertDisplayModel.strMeal = value
                    case "strCategory":
                        dessertDisplayModel.strCategory = value
                    case "strArea":
                        dessertDisplayModel.strArea = value
                    case "strInstructions":
                        // Filter instructions by newline
                        dessertDisplayModel.strInstructions = value.split(whereSeparator: \.isNewline)
                    case "strMealThumb":
                        dessertDisplayModel.strMealThumb = value
                    case _ where label.contains("strIngredient"):
                        // Remove any trailing whitespaces for display clarity with regular expression
                        dessertDisplayModel.strIngredients.append(value.replacingOccurrences(of: "\\s+$",
                                                                                             with: "",
                                                                                             options: .regularExpression))
                    case _ where label.contains("strMeasure"):
                        // Remove any trailing whitespaces for display clarity with regular expression
                        dessertDisplayModel.strMeasure.append(value.replacingOccurrences(of: "\\s+$",
                                                                                         with: "",
                                                                                         options: .regularExpression))
                    case "strSource":
                        dessertDisplayModel.strSource = value
                    default:
                        break
                    }
                }
            }
        }
        
        // Assign strTotalIngredients For Display Purposes
        if dessertDisplayModel.strIngredients.count == dessertDisplayModel.strMeasure.count {
            for index in dessertDisplayModel.strIngredients.indices {
                if let firstCharMeasure = dessertDisplayModel.strMeasure[index].first {
                    // In the case that the measurement should be in the front resulting in regular assignment
                    // 1. First character is a number
                    // 2. First character is a uppercased letter
                    if firstCharMeasure.isUppercase || firstCharMeasure.isNumber {
                        dessertDisplayModel.strTotalIngredients.append(TotalIngredients(ingredient: dessertDisplayModel.strIngredients[index],
                                                                                        measure: dessertDisplayModel.strMeasure[index]))
                    }
                    else {
                        // For measurements that don't have numbers, swap ingredients and measurements
                        dessertDisplayModel.strTotalIngredients.append(TotalIngredients(ingredient: dessertDisplayModel.strMeasure[index],
                                                                                        measure: dessertDisplayModel.strIngredients[index]))
                    }
                }
            }
        }
        
        return dessertDisplayModel
    }
}
