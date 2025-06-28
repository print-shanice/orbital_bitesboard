//
//  UserStatView.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        HStack(spacing: 5){
            Text("\(value)")
                .bold()
            Text(title)
                
        }
        .font(.footnote)
        .foregroundColor(.black)
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
       
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 100, title: "followers")
    }
}
