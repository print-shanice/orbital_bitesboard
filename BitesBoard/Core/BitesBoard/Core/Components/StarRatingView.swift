//
//  StarRatingView.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { index in
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
                .foregroundColor(Color.black.opacity(0.7))
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 4)
        .background(Color.clear)
        .cornerRadius(8)
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: 3)
    }
}
