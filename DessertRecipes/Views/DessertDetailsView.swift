//
//  DessertDetailsView.swift
//  DessertRecipes
//
//  Created by Ricky Zheng on 6/20/23.
//

import SwiftUI

struct DessertDetailsView: View {
    @StateObject var dvm: DetailViewModel = DetailViewModel()
    
    // Used to identify
    @State var idMeal: String = "52966"
    
    var body: some View {
        ZStack {
            Color.brown.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            ScrollView {
                if idMeal.isEmpty {
                    Text("Placeholder Name")
                }
                else {
                    // Display Header Information
                    VStack {
                        Text(dvm.dessertDisplayModel.strMeal)
                            .font(.custom("Didot", size: 35))
                            .bold()
                            .multilineTextAlignment(.center)
                        HStack {
                            Text(dvm.dessertDisplayModel.strArea + " " + dvm.dessertDisplayModel.strCategory)
                                .font(.custom("Didot", size: 25))
                        }
                    }
                    
                    // Display Thumbnail
                    AsyncImage(url: URL(string: dvm.dessertDisplayModel.strMealThumb)) { image in
                        image
                            .resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 393, height: 300)
                    
                    // Display Instructions
                    VStack(alignment: .leading) {
                        Text("Instructions: ")
                            .font(.custom("Didot", size: 30))
                            .bold()
                            .padding(.leading, 1)
                            .padding(.bottom)
                        ForEach(Array(dvm.dessertDisplayModel.strInstructions.enumerated()), id: \.offset) { index, instruction in
                            Text("\(index + 1). " + instruction)
                                .font(.custom("Didot", size: 18))
                                .padding(.bottom)
                        }
                    }
                    .padding(.leading, 8)
                    
                    // Display ingredients along with corresponding measurements
                    VStack(alignment: .leading) {
                        Text("Ingredients: ")
                            .font(.custom("Didot", size: 30))
                            .bold()
                            .padding(.leading, 10)
                            .padding(.bottom)
                        HStack {
                            // Display Measurements
                            VStack(alignment: .leading) {
                                ForEach(dvm.dessertDisplayModel.strTotalIngredients, id: \.self) { total in
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
            .onAppear {
                dvm.fetch(idMeal: idMeal)
            }
//            .scrollIndicators(.hidden)
        }
    }
}

struct DessertDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailsView()
    }
}
