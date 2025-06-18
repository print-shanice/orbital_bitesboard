//
//  DietaryRestrictionsView.swift
//  BitesBoard
//
//  Created by lai shanice on 14/6/25.
//
import SwiftUI

struct DietaryRestrictionsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel:  EditProfileViewModel
    
    let dietaryTags = ["Vegetarian", "Vegan", "Gluten-free", "Halal", "Kosher", "Pescatarian", "Non-spicy", "Lactose-free", "Diary-free", "Keto", "Sugar-free", "Nut-free", "Shellfish-free", "Organic", "No MSG", "None"]
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
        
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dietaryTags, id: \.self) { restriction in
                    MultipleSelectionRow(title: restriction, isSelected: viewModel.dietaryRestrictions.contains(restriction)) {
                        toggleSelection(for: restriction)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Your Dietary Restrictions")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            try await viewModel.updateUserDietaryRestrictions()
                            dismiss()
                        }
                    }
                    .foregroundStyle(.red)
                }
            }
        }
    }
    
    private func toggleSelection(for restriction: String) {
        if let index = viewModel.dietaryRestrictions.firstIndex(of: restriction) {
            viewModel.dietaryRestrictions.remove(at: index)
        } else {
            viewModel.dietaryRestrictions.append(restriction)
        }
    }
}

struct MultipleSelectionRow: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.red)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}


struct DietaryRestrictionsView_Previews: PreviewProvider {
    static var previews: some View {
        DietaryRestrictionsView(user: User.MOCK_USERS[0])
    }
}
