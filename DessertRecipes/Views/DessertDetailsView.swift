//
//  DessertDetailsView.swift
//  DessertRecipes
//
//  Created by Ricky Zheng on 6/20/23.
//

import SwiftUI

struct DessertDetailsView: View {
    @StateObject var dvm: DetailViewModel = DetailViewModel()
    @State var idMeal: String = ""
    
    var body: some View {
        VStack {
            if idMeal.isEmpty {
                Text("Placeholder Name")
            }
            else {
                ForEach(dvm.detailedMeals.meals, id: \.self) { meal in
                    Text(meal.strMeal)
                    Text(idMeal)
                    AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                        image
                            .resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 300, height: 300)
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
