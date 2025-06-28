//
//  Filters.swift
//  BitesBoard
//
//  Created by lai shanice on 15/6/25.
//

import Foundation

struct ReviewFilters: Identifiable, Codable, Hashable {
    var id = UUID()
    var minRating: Double?
    var maxRating: Int?
    var maxBudget: Int?
    var selectedCuisineCategories: [String] = []
    var selectedDietaryRestrictions: [String] = []
    var sortBy: SortOption = .dateDesc
    enum SortOption: String, CaseIterable, Codable, Hashable {
        case dateDesc = "Newest"
        case ratingAsc = "Rating ↑"
        case ratingDesc = "Rating ↓"
        case priceDesc = "Price ↓"
    }

  
    static var `default`: ReviewFilters {
        ReviewFilters(minRating: 0.5, maxRating: 5, maxBudget: 50)
    }
}
