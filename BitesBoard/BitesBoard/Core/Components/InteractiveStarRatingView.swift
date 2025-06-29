//
//  InteractiveStarRatingView.swift
//  BitesBoard
//
//  Created by lai shanice on 10/6/25.
//

import SwiftUI

struct InteractiveStarRatingView: View {
    @Binding var rating: Double

    let maxRating = 5
    let spacing: CGFloat = 2
    let starSize: CGFloat = 30

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: spacing) {
                ForEach(0..<maxRating, id: \.self) { index in
                    let starValue = Double(index)
                    Image(systemName: {
                        if rating >= starValue + 1 {
                            return "star.fill"
                        } else if rating >= starValue + 0.5 {
                            return "star.leadinghalf.filled"
                        } else {
                            return "star"
                        }
                    }())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: starSize, height: starSize)
                    .foregroundColor(.gray)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let totalWidth = geometry.size.width
                        let percent = max(0, min(1, value.location.x / totalWidth))
                        let rawRating = Double(percent) * Double(maxRating)
                        let rounded = (rawRating * 2).rounded() / 2
                        rating = rounded
                    }
            )
        }
        .frame(height: starSize)
    }
}


