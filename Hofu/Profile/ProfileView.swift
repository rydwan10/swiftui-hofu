//
//  ProfileView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 02/04/25.
//

import SwiftUI

struct ProfileView: View {
    let profileImage: String = "Sakura"
    let userName: String = "John Doe"
    let userEmail: String = "johndoe@email.com"
    
    @EnvironmentObject var authManager: AuthManager
    
    var obscuredEmail: String {
        let parts = userEmail.split(separator: "@").map { String($0) }
        guard parts.count == 2 else { return userEmail }
        let obscuredLocal = String(repeating: "*", count: parts[0].count)
        return obscuredLocal + "@" + parts[1]
    }
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Profile")
                    .style(.displayXs(.semiBold))
                Spacer()
            }
            // Profile Header
            HofuCard {
                HStack(spacing: 0) {
                    Image(profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .padding(.trailing, 16)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(userName)
                            .style(.textLg(.semiBold))
                            
                        Text(obscuredEmail)
                            .style(.textMd())
                            .foregroundStyle(.gray600)
                    }
                    Spacer()
                }
            }

            // Menu Items
            HofuCard {
                VStack(spacing: 16) {
                    ProfileMenuItem(
                        icon: "ic_user_outline",
                        title: "Account",
                        subTitle: "Manage your profile and privacy"
                    )
                    ProfileMenuItem(
                        icon: "ic_globe_outline",
                        title: "Language",
                        subTitle: "Change your language"
                    )
//                    ProfileMenuItem(
//                        icon: "",
//                        title: "Theme",
//                        subTitle: "Change your app theme"
//                    )
                    ProfileMenuItem(
                        icon: "ic_credit_card_outline",
                        title: "Payment Methods",
                        subTitle: "Add or manage your payment cards"
                    )
                    ProfileMenuItem(
                        icon: "ic_bell",
                        title: "Notifications",
                        subTitle: "Turn on/off notificaitons"
                    )
                    ProfileMenuItem(
                        icon: "ic_help_circle_outline",
                        title: "Help Center",
                        subTitle: "Get answers to your questions"
                    )
                    
                    ProfileMenuItem(
                        icon: "ic_book_check_outline",
                        title: "Terms and Condition",
                        subTitle: "View our terms and condition"
                    )
                }
            }
            
            HofuOutlineButton(title: "Log Out", type: .error, onPressed: {
                authManager.logout()
            }, isFullWidth: true)
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal, 16)
        .background(.gray25)
    }
}

struct ProfileMenuItem: View {
    let icon: String
    let title: String
    let subTitle: String
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.blue)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(title)
                    .style(.textSm())
                    .padding(.bottom, 2)
                Text(subTitle)
                    .style(.textXs())
                    .foregroundColor(.gray400)
            }
           
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthManager())
}
