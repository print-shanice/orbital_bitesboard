//
//  FilterView.swift
//  BitesBoard
//
//  Created by lai shanice on 15/6/25.
//
import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var filters: ReviewFilters

    @State private var minRating: Double
    @State private var maxRating: Int
    @State private var maxBudget: Int
    @State private var selectedCuisineCategories: [String]
    @State private var selectedDietaryRestrictions: [String]
    @State private var sortBy: ReviewFilters.SortOption

    @State private var showDietaryRestrictions: Bool = false
    @State private var showCuisine: Bool = false


    let cuisineCategories = ["Local", "Italian", "Japanese", "Mexican", "Indian", "Chinese", "Korean", "American", "Spanish", "Thai", "Vietnamese", "Indonesian", "Malaysian", "French", "Mediterranean"]
    let dietaryRestrictions = ["Vegetarian", "Vegan", "Gluten-free", "Halal", "Kosher", "Pescatarian", "Non-spicy", "Lactose-free", "Diary-free", "Keto", "Sugar-free", "Nut-free", "Shellfish-free", "Organic", "No MSG"]
    

    init(filters: Binding<ReviewFilters>) {
        _filters = filters
        _minRating = State(initialValue: filters.wrappedValue.minRating ?? 0.5)
        _maxRating = State(initialValue: filters.wrappedValue.maxRating ?? 5)
        _maxBudget = State(initialValue: filters.wrappedValue.maxBudget ?? 50)
        _selectedCuisineCategories = State(initialValue: filters.wrappedValue.selectedCuisineCategories)
        _selectedDietaryRestrictions = State(initialValue: filters.wrappedValue.selectedDietaryRestrictions)
        _sortBy = State(initialValue: filters.wrappedValue.sortBy)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // choose dietary restrictions
                        FilterSectionView(
                            title: "Dietary Restrictions",
                            isExpanded: $showDietaryRestrictions,
                            selectedItems: $selectedDietaryRestrictions,
                            availableItems: dietaryRestrictions
                        )
                        Divider()

                        //choose cuisine
                        FilterSectionView(
                            title: "Cuisine",
                            isExpanded: $showCuisine,
                            selectedItems: $selectedCuisineCategories,
                            availableItems: cuisineCategories
                        )
                        Divider()

                        // interactive rating glider
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Minimum Rating")
                                .font(.headline)
                                .padding(.horizontal)

                            VStack(alignment: .leading) {
                                Slider(value: $minRating, in: 0.5 ... 5.0, step: 0.5) {
                                    Text("Rating")
                                } minimumValueLabel: {
                                    Text("0.5")
                                } maximumValueLabel: {
                                    Text("5")
                                }
                                .tint(.red)
                                .padding(.horizontal)

                                Text(String(format: "%.1f Stars", minRating))
                                    .font(.subheadline)
                                    .padding(.horizontal)
                            }
                        }
                        Divider()

                        // interactive price glider
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Maximum Budget")
                                .font(.headline)
                                .padding(.horizontal)

                            VStack(alignment: .leading) {
                                Slider(value: Binding(get: {
                                    Double(maxBudget - 10) / 40.0
                                }, set: { newValue in
                                    maxBudget = Int(newValue * 40.0) + 10
                                }), in: 0...1, step: 0.025) {
                                    Text("Budget")
                                } minimumValueLabel: {
                                    Text("$10")
                                } maximumValueLabel: {
                                    Text("$50+")
                                }
                                .tint(.red)
                                .padding(.horizontal)
                                
                                Text(maxBudget == 50 ? "$50+" : "$\(maxBudget)")
                                    .font(.subheadline)
                                    .padding(.horizontal)
                            }
                        }
                        Divider()

                        // sort by
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Sort By")
                                .font(.headline)
                                .padding(.horizontal)
                            Picker("Sort Option", selection: $sortBy) {
                                ForEach(ReviewFilters.SortOption.allCases, id: \.self) { option in
                                    Text(option.rawValue).tag(option)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(.horizontal)
                        }
                        Divider()
                        
                        Spacer()
                    }
                }
                .padding(.top, 50)
                
                Button(action: {
                    filters = .default
                    dismiss()
                }) {
                    Text("Clear filters")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .padding(.bottom, 10)
                .background(Color.white)
            }
            .navigationTitle("Apply Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        filters.minRating = minRating
                        filters.maxRating = maxRating
                        filters.maxBudget = maxBudget
                        filters.selectedCuisineCategories = selectedCuisineCategories
                        filters.selectedDietaryRestrictions = selectedDietaryRestrictions
                        filters.sortBy = sortBy
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
            }
        }
    }
}




struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filters: .constant(.default))
    }
}
