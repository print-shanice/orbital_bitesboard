//
//  ViewDietaryTagsView.swift
//  BitesBoard
//
//  Created by lai shanice on 14/6/25.
//

import SwiftUI

struct ViewDietaryTagsView: View {
    let selectedTags: [String]
    @State private var showTags = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                withAnimation {
                    showTags.toggle()
                }
            } label: {
                Image(systemName: "fork.knife")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .padding(6)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .foregroundStyle(.red)
            }

            if showTags && !selectedTags.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(selectedTags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray)
                            .cornerRadius(6)
                    }
                }
                .padding(8)
                .cornerRadius(10)
                .shadow(radius: 4)
                .offset(y: 36)
                .zIndex(1)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}
