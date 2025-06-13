//
//  DietaryTagsMenuView.swift
//  BitesBoard
//
//  Created by lai shanice on 13/6/25.
//
import SwiftUI


struct DietaryTagsMenuView: View {
    @State private var isExpanded = false
    @Binding var selectedTags: [String]
    
    let dietaryTags = ["Vegetarian", "Vegan", "Gluten-Free", "Halal", "Kosher", "Pescatarian", "Non-spicy", "Lactose-free", "Diary-free", "Keto", "Sugar-free"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                isExpanded.toggle()
            }) {
                HStack {
                    Text("Dietary Tags")
                        .font(.headline)
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.red)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                .frame(width: 180, height: 60)
            }
            .padding(.leading)
            
            if isExpanded {
                ForEach(dietaryTags, id: \.self) { tag in
                    Button(action: {
                        if selectedTags.contains(tag) {
                            selectedTags .removeAll { $0 == tag }
                        } else {
                            selectedTags.append(tag)
                        }
                    }) {
                        HStack {
                            Text(tag)
                            Spacer()
                            if selectedTags.contains(tag) {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.red)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .foregroundColor(.black)
                    .padding(.leading)
                }
            }

        }
        .padding()
    }
}



