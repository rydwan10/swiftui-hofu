//
//  RoomDetailHeaderView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/03/25.
//

import SwiftUI

struct RoomDetailHeaderView: View {
    let roomInfo: RoomInfo

    var body: some View {
        VStack {
            HofuCard {
                // Room image
                HStack {
                    Image(roomInfo.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipped()
                        .cornerRadius(24)
                    VStack(alignment: .leading) {
                        // Room name
                        Text(roomInfo.title)
                            .style(.displayXs(.semiBold))
                            .padding(.bottom, 4)

                        // Description
                        Text("A luxurious suite with stunning city views, perfect for relaxation and comfort.")
                            .style(.textSm())
                            .foregroundStyle(.gray500)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
    }
}

#Preview {
    RoomDetailHeaderView(
        roomInfo: RoomInfo(
            id: 1, title: "Room Info", price: "1000000"
        )
    )
}
