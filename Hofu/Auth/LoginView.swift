//
//  LoginScreen.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/02/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var routeManager: RouteManager
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 0) {
            Text("Welcome Back")
                .style(.displaySm(.semiBold))

            // Email TextField
            HofuTextField(
                title: "Email",
                placeholder: "Enter your email",
                text: $email,
                helperText: "",
                leadingIcon: Image(systemName: "envelope"),
                isEnabled: true,
                onChange: { _ in }
            )

            // Password TextField
            HofuTextField(
                title: "Password",
                placeholder: "Enter your password",
                text: $password,
                helperText: "",
                leadingIcon: Image(systemName: "lock"),
                isEnabled: true,
                onChange: { _ in }
            )

            // Forgot Password
            HStack {
                Spacer()
                Button(action: {
                    // Handle forgot password
                }) {
                    Text("Forgot Password?")
                        .style(.textSm())
                        .foregroundColor(.blue)
                }
            }

            // Login Button
            HofuButton(
                title: "Login",
                onPressed: {
                    authManager.login(username: "test", password: "test") { _ in
                    }
                },
                isFullWidth: true
            )
            .padding(.top, 20)

            // OR Divider
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.5))
                Text("OR")
                    .foregroundColor(.gray)
                    .font(.caption)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.5))
            }
            .padding(.vertical)

            // Social Login Buttons
            VStack(spacing: 12) {
                HofuOutlineButton(
                    title: "Login with Google",
                    onPressed: {},
                    leadingIcon: { Image(systemName: "globe") },
                    isFullWidth: true
                )
                HofuButton(
                    title: "Login with Apple",
                    type: .black,
                    onPressed: {},
                    leadingIcon: { Image(systemName: "apple.logo") },
                    isFullWidth: true
                )
            }.padding(.bottom)

            // Register Section
            HStack {
                Text("Don't have an account?").style(.textMd())
                Button(action: {
                    // Navigate to register
                    routeManager.navigate(to: .register)
                }) {
                    Text("Register").style(.textMd())
                }
            }
        }

        .padding(.horizontal)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        ).background(.gray25)
    }
}

#Preview {
    let authManager = AuthManager()
    LoginView()
        .environmentObject(RouteManager())
        .environmentObject(authManager)
}
