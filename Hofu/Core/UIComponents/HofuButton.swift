//
//  HofuButton.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 07/02/25.
//

import SwiftUI

enum HofuButtonType {
    case success
    case base
    case error
    case warning
    case black
    
    var backgroundColor: Color {
        switch self {
        case .success:
            return .success500
        case .base:
            return .brand600
        case .error:
            return .error600
        case .warning:
            return .warning400
        case .black:
            return Color.black
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .warning:
            return Color.black
        case .black:
            return Color.white
        default:
            return Color.white
        }
    }
}

struct HofuButton: View {
    let title: String
    let type: HofuButtonType
    let onPressed: (() -> Void)?
    let leadingIcon: (() -> AnyView)?
    let trailingIcon: (() -> AnyView)?
    let isFullWidth: Bool
    
    init(
        title: String,
        type: HofuButtonType = .base,
        onPressed: (() -> Void)? = nil,
        @ViewBuilder leadingIcon: @escaping () -> some View = { EmptyView() },
        @ViewBuilder trailingIcon: @escaping () -> some View = { EmptyView() },
        isFullWidth: Bool = false
    ) {
        self.title = title
        self.type = type
        self.isFullWidth = isFullWidth
        self.onPressed = onPressed
        self.leadingIcon = { AnyView(leadingIcon()) }
        self.trailingIcon = { AnyView(trailingIcon()) }
    }
    
    var body: some View {
        Button(action: {
            onPressed?()
        }) {
            HStack(spacing: 4) {
                leadingIcon?()
                
                Text(title)
                    .style(.textMd(.semiBold))
                
                trailingIcon?()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .background(type.backgroundColor)
            .foregroundColor(type.foregroundColor)
            .clipShape(Capsule())
        }
        .disabled(onPressed == nil)
        .opacity(onPressed == nil ? 0.4 : 1.0)
    }
}

struct HofuButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Success button with both icons
            HofuButton(
                title: "Success",
                type: .success,
                onPressed: { print("Success tapped") },
                leadingIcon: { Image(systemName: "checkmark") },
                trailingIcon: { Image(systemName: "arrow.right") }
            )
            
            // Info button with leading icon
            HofuButton(
                title: "Info",
                type: .base,
                onPressed: { print("Info tapped") },
                leadingIcon: { Image(systemName: "info.circle") }
            )
            
            // Error button with trailing icon
            HofuButton(
                title: "Error",
                type: .error,
                onPressed: { print("Error tapped") },
                trailingIcon: { Image(systemName: "xmark.circle") }
            )
            
            // Warning button without icons
            HofuButton(
                title: "Warning",
                type: .warning,
                onPressed: { print("Warning tapped") }
            )
            
            // Disabled button
            HofuButton(
                title: "Disabled",
                type: .warning
            )
            
            // Black button without icons
            HofuButton(
                title: "Login with Apple",
                type: .black,
                onPressed: { print("Login with apple tapped") },
                leadingIcon: { Image(systemName: "apple.logo") }
            )
        }
        .padding()
    }
}
