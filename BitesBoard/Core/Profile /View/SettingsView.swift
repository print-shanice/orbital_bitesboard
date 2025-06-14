//
//  SettingsView.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI

struct SettingsView: View {
    let user: User
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack{
                    Text("Settings")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    Spacer(minLength: 60)
                    Button("Done") {
                        dismiss()
                    }
                    .font(.callout)
                    .foregroundColor(.red)
                    .padding(.bottom, 30)
                    .padding(.horizontal)
                    .padding(.top, 10)
                }

                Group {
                    SettingsRowView(systemImageName: "bookmark", title: "Bookmarks", subtitle: "View your saved posts", destination: AnyView(BookmarkView(user: user)))
                    
                    Divider()
                    
                    SettingsRowView(systemImageName: "mappin.circle", title: "Saved locations", subtitle: "Edit your saved locations", destination: AnyView(BookmarkView(user: user)))
                    
                    Divider()
                    
                    SettingsRowView(systemImageName: "lock", title: "Privacy", subtitle: "Edit your privacy settings", destination: AnyView(BookmarkView(user: user)))
                    
                    Divider()
                    
                    SettingsRowView(systemImageName: "fork.knife", title: "Dietary Restrictions", subtitle: "Update your dietary restrictions", destination: AnyView(DietaryRestrictionsView(user: user)))
                    
                    Divider()
                    
                    SettingsRowView(systemImageName: "person", title: "Profile", subtitle: "Edit your profile details", destination: AnyView(EditProfileView(user: user)))
                    
                    Divider()
                    
                    SettingsRowView(systemImageName: "bell", title: "Notifications", subtitle: "Control your notification settings", destination: AnyView(BookmarkView(user: user)))
                    
                    Divider()
                    
                    SettingsRowView(systemImageName: "envelope", title: "Verify your Account", subtitle: "Verify your email address", destination: AnyView(BookmarkView(user: user)))
                    
                    Divider()
                    
                    Button(action: {
                        AuthService.shared.signOut()
                    }) {
                        HStack(alignment: .top, spacing: 40) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.black)
                                .padding(.top, 2)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Log out")
                                    .foregroundStyle(.black)
                                    .fontWeight(.semibold)
                                Text("Log out of your account")
                                    .foregroundStyle(.gray)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.vertical, 16)
                    }
                    .padding(.leading, 5)
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
        }
    }
}


struct SettingsRowView: View {
    let systemImageName: String
    let title: String
    let subtitle: String
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(alignment: .top, spacing: 40) {
                Image(systemName: systemImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.black)
                    .padding(.top, 2)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                    Text(subtitle)
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal)
        }
    }
}


    
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user: User.MOCK_USERS[0])
    }
}

