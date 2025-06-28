//
//  FilterSectionView.swift
//  BitesBoard
//
//  Created by lai shanice on 16/6/25.
//
import SwiftUI

struct FilterSectionView: View {
    let title: String
    @Binding var isExpanded: Bool
    @Binding var selectedItems: [String]
    let availableItems: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .font(.headline)
                    Spacer()
                    
                    Image(systemName: {
                        if isExpanded {
                            return "chevron.up"
                        } else {
                            if selectedItems.isEmpty {
                                return "chevron.right"
                            } else {
                                return "checkmark.circle.fill"
                            }
                        }
                    }())
                    .foregroundColor(isExpanded ? .gray : (selectedItems.isEmpty ? .gray : .green))
                }
                .padding(.horizontal)
                .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())

            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(availableItems, id: \.self) { item in
                        Button(action: {
                            if selectedItems.contains(item) {
                                selectedItems.removeAll(where: { $0 == item })
                            } else {
                                selectedItems.append(item)
                            }
                        }) {
                            HStack {
                                Text(item)
                                    .foregroundColor(.primary)
                                Spacer()
                                if selectedItems.contains(item) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.bottom, 10)
            } else if !selectedItems.isEmpty {
                Text(selectedItems.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            } else {
                Text("Click to expand")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
        }
    }
}
