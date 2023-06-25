//
//  ContentView.swift
//  DessertRecipes
//
//  Created by Ricky Zheng on 6/20/23.
//

import SwiftUI

struct DessertListView: View {
    @StateObject var vm: ListViewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.brown.opacity(0.2).ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Desserts")
                            .font(.custom("Didot", size: 35))
                            .bold()
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
                    List {
                        // Sort Dessert Names Displayed
                        ForEach(vm.meals.meals.sorted { $0.strMeal < $1.strMeal}, id: \.idMeal) { meal in
                            NavigationLink(destination: {
                                DessertDetailsView(idMeal: meal.idMeal)
                            }, label: {
                                HStack {
                                    Text("")
                                    AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                        image
                                            .resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 100, height: 100)
                                    
                                    Text(meal.strMeal)
                                        .font(.custom("Didot", size: 20))
                                }
                            })
                            .listRowBackground(Color.brown.opacity(0.05).ignoresSafeArea())
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(PlainListStyle())
                    .onAppear {
                        vm.fetch()
                    }
                }
            }
        }
    }
}

struct DessertListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
    }
}
