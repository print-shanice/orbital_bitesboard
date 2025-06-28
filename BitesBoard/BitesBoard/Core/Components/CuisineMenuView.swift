//
//  CuisineMenuView.swift
//  BitesBoard
//
//  Created by lai shanice on 16/6/25.
//
import SwiftUI

struct CuisineMenuView: View {
    @State private var isExpanded = false
    @Binding var selectedCuisine: String?
    
    let cuisines =  ["Local", "Italian", "Japanese", "Mexican", "Indian", "Chinese", "Korean", "American", "Spanish", "Thai", "Vietnamese", "Indonesian", "Malaysian", "French", "Mediterranean"]

    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                isExpanded.toggle()
            }) {
                HStack {
                    Text(selectedCuisine ?? "Cuisine")
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
                ForEach(cuisines, id: \.self) { cuisine in
                    Button(action: {
                        if selectedCuisine == cuisine {
                            selectedCuisine = nil
                        } else {
                            selectedCuisine = cuisine
                        }
                        isExpanded = false
                    }) {
                        HStack {
                            Text(cuisine)
                            Spacer()
                            if selectedCuisine == cuisine {
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
