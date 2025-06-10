//
//  CircularProfileImageView.swift
//  BitesBoard
//
//  Created by lai shanice on 10/6/25.
//

import SwiftUI
import Kingfisher

struct CircularProfileImageView: View {
    let user: User
    let size: ProfileImageSize
    var body: some View {
        if let imageURL = user.profilePicture {
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundStyle(.gray)
        }
    }
}

enum ProfileImageSize {
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .small:
            return 32
        case .medium:
            return 64
        case .large:
            return 80
        }
    }
}


struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: User.MOCK_USERS[0], size: .medium)
    }
}
