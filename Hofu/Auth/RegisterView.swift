//
//  RegisterView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/02/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    var body: some View {
        VStack {
            Text("Register your account").style(.displaySm(.semiBold))
                .padding(.bottom)

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
            // Confirm Password TextField
            HofuTextField(
                title: "Confirm Password",
                placeholder: "Re-Enter your password",
                text: $password,
                helperText: "",
                leadingIcon: Image(systemName: "lock"),
                isEnabled: true,
                onChange: { _ in }
            )

            // Register button
            HofuButton(
                title: "Register", onPressed: {}, isFullWidth: true
            ).padding(.bottom)
            HStack(spacing: 0) {
                Text("Already have an account? ")
                Button(action: {}) {
                    Text("Login").style(.textMd(.semiBold))
                }
            }

        }.padding(.horizontal)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            ).background(.gray25)
//            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterView()
}
