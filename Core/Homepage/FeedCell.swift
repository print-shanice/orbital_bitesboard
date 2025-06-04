//
//  FeedCell.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack(spacing: 10){
        //pfp, username and restaraunt
            HStack{
                Image("janice")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text("Janice")
                    .font(.footnote)
                    .fontWeight(.bold)
                Text("at")
                    .font(.footnote)
                Text("Ikseoyang")
                    .font(.footnote)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.leading)
        //food photo
            ZStack(alignment: .bottomLeading){
                Image("food")
                    .resizable()
                    .clipShape(Rectangle())
                    .scaledToFill()
                    .frame(height: 250)
                    .cornerRadius(10)
                    .overlay(alignment: .topTrailing){
                        Button(action: {}){
                            Image(systemName: "bookmark")
                                .resizable()
                                .frame(width: 30, height: 40)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical, 10)
                    }
                StarRatingView(rating: 4.5)
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    
            }
            .padding(.horizontal)
        //caption and likes
            VStack{
                HStack {
                    Text("zhen zhen would approve")
                        .font(.subheadline)
                    Spacer()
                }
                .padding(.leading)
                
                HStack {
                    Button(action: {}){
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    Spacer()
                }
                .padding(.leading)
            }
            
        }
    }
}

#Preview {
    FeedCell()
}
