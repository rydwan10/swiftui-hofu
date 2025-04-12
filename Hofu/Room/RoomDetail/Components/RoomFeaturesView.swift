//
//  RoomFeaturesView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/03/25.
//

import SwiftUI

struct RoomFeaturesView: View {
    var body: some View {
        HofuCard {
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    RoomFeatureItemView(
                        icon: "ic_star",
                        text: "5.0 Rating",
                        color: .warning400
                    )
                    Spacer()
                    RoomFeatureItemView(
                        icon: "ic_wifi_outline",
                        text: "Free Wi-Fi",
                        color: .gray600
                    )
                    Spacer()
                    RoomFeatureItemView(
                        icon: "ic_sunrise_outline",
                        text: "Breakfast Included",
                        color: .gray600
                    )
                }
                Text("See all amenities")
                    .style(.textSm(.semiBold))
                    .foregroundStyle(.brand600)
            }
        }
    }
}

struct RoomFeatureItemView: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .foregroundStyle(color)
            Text(text)
                .style(.textSm())
        }
    }
}

#Preview {
    RoomFeaturesView()
}
