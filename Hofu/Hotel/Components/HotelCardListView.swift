//
//  HotelCardListView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 13/02/25.
//

import SwiftUI

struct HotelCardList: View {
    let image: String
    let title: String
    let city: String
    let country: String
    let startingPrice: Double
    let rating: Double

    var body: some View {
        HStack(spacing: 16) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(12)
                .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(title).style(.textSm(.semiBold))
                HStack (spacing: 0){
                    Text(city + ", ")
                        .style(.textXs(.regular))
                    Text(country)
                        .style(.textXs(.semiBold))
                }
                HStack(alignment: .center) {
                    Text("Starts from")
                        .style(.textXss(.semiBold))
                        .foregroundStyle(.gray600)
//                    Spacer()
                    Text("Rp \(String(format: "%.2f", startingPrice))")
                        .style(.textXs(.semiBold))
                }
                Text("\(String(rating))/5").style(.textXs(.semiBold))
            }
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(
            color: Color(.Gray600, opacity: 0.1),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

struct HotelCardList_Previews: PreviewProvider {
    static var previews: some View {
        HotelCardList(
            image: "Sakura",
            title: "Hotel Sakura",
            city: "Tokyo",
            country: "Japan",
            startingPrice: 150_000,
            rating: 4.5
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
