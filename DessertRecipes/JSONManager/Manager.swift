//
//  Manager.swift
//  DessertRecipes
//
//  Created by Ricky Zheng on 6/20/23.
//

import Foundation

// Create a viewmodel for list of meal api endpoint
class ListViewModel: ObservableObject {
    @Published var meals: Meals = Meals(meals: [])
    
    func fetch() {
        // API Endpoint to Retrieve List of Desserts
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        let apiCall = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert JSON Data
            do {
                let meals = try JSONDecoder().decode(Meals.self, from: data)
                DispatchQueue.main.async {
                    self?.meals = meals
                }
            }
            catch {
                print(error)
            }
        }
        
        apiCall.resume()
    }
}

// Create a another viewmodel for individual meal api endpoint
class DetailViewModel: ObservableObject {
    @Published var detailedMeals: DetailedMeals = DetailedMeals(meals: [])
    @Published var dessertDisplayModel: DessertDisplayModel = DessertDisplayModel()
    
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
                            self?.dessertDisplayModel = dessertDetails
                            print(dessertDetails)
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
    
    func filterDesserts(detailedMeal: DetailedMeal) -> DessertDisplayModel {
        var dessertDisplayModel: DessertDisplayModel = DessertDisplayModel()
//        var dessertDetails: [(String, String)] = []
        
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
                        dessertDisplayModel.strIngredients.append(value)
                    case _ where label.contains("strMeasure"):
                        dessertDisplayModel.strMeasure.append(value)
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
                // For measurement strings that don't have a numbers, swap ingredients and measurements
                if let firstChar = dessertDisplayModel.strMeasure[index].first {
                    if !firstChar.isNumber {
                        dessertDisplayModel.strTotalIngredients.append(TotalIngredients(ingredient: dessertDisplayModel.strMeasure[index],
                                                                                        measure: dessertDisplayModel.strIngredients[index]))
                    }
                    else {
                        dessertDisplayModel.strTotalIngredients.append(TotalIngredients(ingredient: dessertDisplayModel.strIngredients[index],
                                                                                        measure: dessertDisplayModel.strMeasure[index]))
                    }
                }
                else {
                    // Measurement doesn't start with letter
                    dessertDisplayModel.strTotalIngredients.append(TotalIngredients(ingredient: dessertDisplayModel.strIngredients[index],
                                                                                    measure: dessertDisplayModel.strMeasure[index]))
                }
            }
        }
        
        return dessertDisplayModel
    }
}

struct DessertDisplayModel: Hashable {
    var idMeal: String = ""
    var strMeal: String = ""
    var strCategory: String = ""
    var strArea: String = ""
    var strInstructions: [String.SubSequence] = []
    var strMealThumb: String = ""
    var strIngredients: [String] = []
    var strMeasure: [String] = []
    var strTotalIngredients: [TotalIngredients] = []
    var strSource: String = ""
}

struct TotalIngredients: Hashable {
    var ingredient: String = ""
    var measure: String = ""
}

struct DetailedMeal: Codable, Hashable {
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYouTube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dataModified: String?
}

struct DetailedMeals: Codable {
    let meals: [DetailedMeal]
}

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct Meals: Codable {
    let meals: [Meal]
}

