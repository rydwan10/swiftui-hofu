//
//  HofuCircleButton.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 07/02/25.
//

import SwiftUI

struct HofuCircleButton: View {
    let icon: () -> AnyView
    let onPressed: (() -> Void)?
    let buttonSize: CGFloat
    let iconPadding: CGFloat
    let iconSize: CGFloat

    init(
        @ViewBuilder icon: @escaping () -> some View,
        buttonSize: CGFloat = 40,
        iconPadding: CGFloat = 8,
        iconSize: CGFloat = 24,
        onPressed: (() -> Void)? = nil
    ) {
        self.icon = { AnyView(icon()) }
        self.buttonSize = buttonSize
        self.iconPadding = iconPadding
        self.iconSize = iconSize
        self.onPressed = onPressed
    }

    var body: some View {
        Button(action: {
            onPressed?()
        }) {
            icon()
                .frame(width: iconSize, height: iconSize)
                .padding(iconPadding)
                .background(Color.white)
                .foregroundColor(Color.black)
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: 1)
                )
                .frame(width: buttonSize, height: buttonSize)
                .clipShape(Circle())
        }
        .disabled(onPressed == nil)
        .opacity(onPressed == nil ? 0.6 : 1.0)
    }
}


struct HofuCircleButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Regular size button
            HofuCircleButton(
                icon: { Image(systemName: "plus") },
                buttonSize: 40,
                iconPadding: 8,
                iconSize: 24,
                onPressed: { print("Button tapped") }
            )
            
            // Larger button
            HofuCircleButton(
                icon: { Image(systemName: "star.fill") },
                buttonSize: 60,
                iconPadding: 12,
                iconSize: 32,
                onPressed: { print("Large button tapped") }
            )
            
            // Disabled button
            HofuCircleButton(
                icon: { Image(systemName: "xmark") },
                buttonSize: 40,
                iconPadding: 8,
                iconSize: 24
            )
        }
        .padding()
    }
}
