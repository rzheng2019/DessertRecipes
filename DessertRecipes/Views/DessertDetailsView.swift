//
//  DessertDetailsView.swift
//  DessertRecipes
//
//  Created by Ricky Zheng on 6/20/23.
//

import SwiftUI

struct Ingredients {
    var ingredients: [String] = []
}

struct Measurements {
    var measurements: [String] = []
}

struct DessertDetailsView: View {
    @StateObject var dvm: DetailViewModel = DetailViewModel()
    
    // Used to identify
    @State var idMeal: String = "53049"
    
    var body: some View {
        ScrollView {
            if idMeal.isEmpty {
                Text("Placeholder Name")
            }
            else {
                // Display Thumbnail
                AsyncImage(url: URL(string: dvm.dessertDisplayModel.strMealThumb)) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 300)
                
                // Display Instructions
                VStack {
                    Text(dvm.dessertDisplayModel.strInstructions)
                }
                
                // Display Ingredients
                
                ForEach(dvm.dessertDisplayModel.strIngredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                
                Spacer()
                
                // Display Measurements
                ForEach(dvm.dessertDisplayModel.strMeasure, id: \.self) { measure in
                    Text(measure)
                }
                
            }
        }
        .onAppear {
            dvm.fetch(idMeal: idMeal)
        }
    }
}

struct DessertDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailsView()
    }
}
