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
    let size: CGFloat
    
    init(
        @ViewBuilder icon: @escaping () -> some View,
        size: CGFloat = 40,
        onPressed: (() -> Void)? = nil
    ) {
        self.icon = { AnyView(icon()) }
        self.size = size
        self.onPressed = onPressed
    }
    
    var body: some View {
        Button(action: {
            onPressed?()
        }) {
            icon()
                .frame(width: size, height: size)
                .background(Color.white)
                .foregroundColor(Color.black)
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: 1)
                )
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
                onPressed: { print("Button tapped") }
            )
            
            // Larger button
            HofuCircleButton(
                icon: { Image(systemName: "star.fill") },
                size: 60,
                onPressed: { print("Large button tapped") }
            )
            
            // Disabled button
            HofuCircleButton(
                icon: { Image(systemName: "xmark") }
            )
        }
        .padding()
    }
}
