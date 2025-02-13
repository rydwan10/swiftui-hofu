//
//  HofuCard.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 08/02/25.
//

import SwiftUI

struct HofuCard<Content: View>: View {
    let content: Content
    let radius: CGFloat
    
    init(
        radius: CGFloat = 8,
        @ViewBuilder content: () -> Content
    ) {
        self.radius = radius
        self.content = content()
    }
    
    private var shadowColor: Color {
        
        Color(hex: 0x101828)
    }
    
    var body: some View {
        content
            .padding(16)
            .background(Color.white)
            .cornerRadius(radius)
            // Shadow Layer 1 (bottom layer)
            .shadow(
                color: shadowColor.opacity(0.10),
                radius: 2,
                x: 0,
                y: 1
            )
            // Shadow Layer 2 (top layer)
            .shadow(
                color: shadowColor.opacity(0.06),
                radius: 1,
                x: 0,
                y: 1
            )
    }
}

#Preview {
    VStack(spacing: 20) {
        // Default radius card
        HofuCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("Default Card")
                    .font(.headline)
                Text("This card uses the default radius of 8")
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }

        // Custom radius card
        HofuCard(radius: 16) {
            HStack(spacing: 12) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("Custom Radius Card")
                    .font(.headline)
            }
        }

        // Fully rounded card
        HofuCard(radius: 24) {
            VStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.largeTitle)
                Text("Highly Rounded Card")
                    .font(.headline)
            }
        }
    }
    .padding()
    .background(.gray25)
}
