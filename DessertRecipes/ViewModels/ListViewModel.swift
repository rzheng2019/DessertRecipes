//
//  ListViewModel.swift
//  DessertRecipes
//
//  Created by Ricky Zheng on 6/24/23.
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
