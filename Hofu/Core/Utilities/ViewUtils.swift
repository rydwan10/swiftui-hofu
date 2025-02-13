//
//  ViewUtils.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 17/11/24.
//

import Foundation
import SwiftUICore
import UIKit

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

struct CustomBorder: ViewModifier {
    var color: Color
    var lineWidth: CGFloat
    var cornerRadius: CGFloat
    var sides: [Edge] // Pilih sisi yang ingin diberi border

    func body(content: Content) -> some View {
        content

            .overlay(
                ZStack {
                    if sides.contains(.top) {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .trim(from: 0, to: 0.25) // Top
                            .stroke(color, lineWidth: lineWidth)
                    }
                    if sides.contains(.bottom) {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .trim(from: 0.5, to: 0.75) // Bottom
                            .stroke(color, lineWidth: lineWidth)
                    }
                    if sides.contains(.leading) {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .trim(from: 0.25, to: 0.5) // Leading
                            .stroke(color, lineWidth: lineWidth)
                    }
                    if sides.contains(.trailing) {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .trim(from: 0.75, to: 1.0) // Trailing
                            .stroke(color, lineWidth: lineWidth)
                    }
                }
            )
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
            overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
    func customBorder(color: Color, lineWidth: CGFloat = 2, cornerRadius: CGFloat = 10, sides: [Edge]) -> some View {
            self.modifier(CustomBorder(color: color, lineWidth: lineWidth, cornerRadius: cornerRadius, sides: sides))
        }
}
