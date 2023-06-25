//
//  DessertDetailsView.swift
//  DessertRecipes
//
//  Created by Ricky Zheng on 6/20/23.
//

import SwiftUI

struct DessertDetailsView: View {
    @StateObject var dvm: DetailsViewModel = DetailsViewModel()
    
    // Used to identify
    @State var idMeal: String = "52966"
    
    var body: some View {
        ZStack {
            Color.brown.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            ScrollView {
                // Display Header
                DessertHeaderView(name: dvm.displayViewModel.strMeal,
                                  area: dvm.displayViewModel.strArea,
                                  category: dvm.displayViewModel.strCategory)
                
                // Display Thumbnail
                DessertThumbView(mealThumb: dvm.displayViewModel.strMealThumb)
                
                // Display Instructions
                DessertInstructionsView(instructions: dvm.displayViewModel.strInstructions)
                
                // Display Ingredients and Measurements
                DessertIngredientsView(ingredients: dvm.displayViewModel.strTotalIngredients)
                
            }
            .onAppear {
                // Load details of selected dessert
                dvm.fetch(idMeal: idMeal)
            }
        }
    }
}

struct DessertHeaderView: View {
    var name: String = ""
    var area: String = ""
    var category: String = ""
    
    var body: some View {
        VStack {
            Text(name)
                .font(.custom("Didot", size: 35))
                .bold()
                .multilineTextAlignment(.center)
            HStack {
                Text(area + " " + category)
                    .font(.custom("Didot", size: 25))
            }
        }
    }
}

struct DessertThumbView: View {
    var mealThumb: String = ""
    
    var body: some View {
        AsyncImage(url: URL(string: mealThumb)) { image in
            image
                .resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 393, height: 300)
    }
}

struct DessertInstructionsView: View {
    var instructions: [String.SubSequence] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions: ")
                .font(.custom("Didot", size: 30))
                .bold()
                .padding(.leading, 1)
                .padding(.bottom)
            ForEach(Array(instructions.enumerated()), id: \.offset) { index, instruction in
                Text("\(index + 1). " + instruction)
                    .font(.custom("Didot", size: 18))
                    .padding(.bottom)
            }
        }
        .padding(.leading, 8)
    }
}

struct DessertIngredientsView: View {
    var ingredients: [TotalIngredients] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients: ")
                .font(.custom("Didot", size: 30))
                .bold()
                .padding(.leading, 10)
                .padding(.bottom)
            HStack {
                // Display Measurements
                VStack(alignment: .leading) {
                    ForEach(ingredients, id: \.self) { total in
                        Text("\u{2022} " + total.measure + " " + total.ingredient)
                            .font(.custom("Didot", size: 20))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 5)
                    }
                }
                Spacer()
            }
            .padding(.leading, 18)
            .padding(.bottom, 50)
        }
        
        Spacer()
    }
}

struct DessertDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailsView()
    }
}
