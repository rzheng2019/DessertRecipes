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
                VStack {
                    List {
    //                     Sort Dessert Names Displayed
                        ForEach(vm.meals.meals.sorted { $0.strMeal < $1.strMeal}, id: \.idMeal) { meal in
                            NavigationLink(destination: {
                                DessertDetailsView(idMeal: meal.idMeal)
                            }, label: {
                                HStack {
                                    AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                        image
                                            .resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 100, height: 100)
                                    
                                    Text(meal.strMeal)
                                }
                            })
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                    .onAppear {
                        vm.fetch()
                    }
                }
                .padding(.top, 40)
            }
            .ignoresSafeArea()
        }
    }
}

struct DessertListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
    }
}
