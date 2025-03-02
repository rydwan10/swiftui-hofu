//
//  HotelDescriptionCard.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 01/03/25.
//

import SwiftUI

struct HotelDescriptionCard: View {
    let description: String

    var body: some View {
        HofuCard {
            HStack {
                VStack(alignment: .leading) {
                    Text("Description")
                        .style(.textSm(.semiBold))
                        .padding(.bottom, 8)
                    Text(description)
                        .style(.textXs(.regular))
                        .foregroundStyle(.gray500)
                }
                Spacer()
            }
           
        }
    }
}

#Preview {
    HotelDescriptionCard(
        description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem!"
    )
}
