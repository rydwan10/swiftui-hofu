//
//  HofuButtonOutline.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 07/02/25.
//

import SwiftUI

struct HofuOutlineButton: View {
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
        self.onPressed = onPressed
        self.leadingIcon = { AnyView(leadingIcon()) }
        self.trailingIcon = { AnyView(trailingIcon()) }
        self.isFullWidth = isFullWidth
    }
    
    private var isDisabled: Bool {
        onPressed == nil
    }
    
    var body: some View {
        Button(action: {
            onPressed?()
        }) {
            HStack(spacing: 8) {
                leadingIcon?()
                
                Text(title)
                    .style(.textMd(.semiBold)
                    )
                
                trailingIcon?()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .background(
                isDisabled
                    ? Color.gray.opacity(0.1)
                    : Color.white
            )
            .foregroundColor(
                isDisabled
                    ? Color.gray
                    : type.backgroundColor
            )
            .overlay(
                Capsule()
                    .stroke(
                        isDisabled
                            ? Color.gray
                            : type.backgroundColor,
                        lineWidth: 1
                    )
            )
            .clipShape(Capsule())
        }
        .disabled(isDisabled)
    }
}

struct HofuButtonOutline_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Full width success outline button
            HofuOutlineButton(
                title: "Success Outline",
                type: .success,
                onPressed: { print("Success tapped") },
                leadingIcon: { Image(systemName: "checkmark") },
                trailingIcon: { Image(systemName: "arrow.right") },
                isFullWidth: true
            )
            
            // Regular info outline button
            HofuOutlineButton(
                title: "Info Outline",
                type: .base,
                onPressed: { print("Info tapped") },
                leadingIcon: { Image(systemName: "info.circle") }
            )
            
            // Full width error outline button
            HofuOutlineButton(
                title: "Error Outline",
                type: .error,
                onPressed: { print("Error tapped") },
                trailingIcon: { Image(systemName: "xmark.circle") },
                isFullWidth: true
            )
            
            // Regular warning outline button
            HofuOutlineButton(
                title: "Warning Outline",
                type: .warning,
                onPressed: { print("Warning tapped") }
            )
            
            // Disabled outline button
            HofuOutlineButton(
                title: "Disabled Outline",
                type: .base,
                isFullWidth: true
            )
            
            // Another disabled button with icons
            HofuOutlineButton(
                title: "Disabled With Icons",
                type: .success,
                leadingIcon: { Image(systemName: "star.fill") },
                trailingIcon: { Image(systemName: "arrow.right") }
            )
        }
        .padding()
    }
}
