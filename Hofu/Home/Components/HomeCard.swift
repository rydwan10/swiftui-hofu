//
//  HomeCard.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 19/11/24.
//

import SwiftUI

struct HomeCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Discover")
//                    .font(.inter(size: 20, weight: .bold))
                    .underline(true, color: .warning500)
//                    .bold()
            }.padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    HomeCardItem()
                    HomeCardItem()
                    HomeCardItem()
                    HomeCardItem()
                }.padding(.horizontal, 16)
            }
        }
    }
}

struct HomeCardItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("Sakura")
                .resizable()
//                .scaledToFill()
                .frame(width: 128, height: 128)
                .clipShape(RoundedCorner(radius: 24, corners: [.bottomLeft, .bottomRight, .topRight, .topLeft]))
            VStack(alignment: .leading) {
                Text("Beijing")
                    .font(.system(size: 12))
                    .bold()
                    .padding(.bottom, 4)
                Text("China").font(.system(size: 12))
            }
            .padding(EdgeInsets(top: 8, leading: 12, bottom: 12, trailing: 12))
        }
        .background(Color.white)
        .cornerRadius(24)
        .shadow(
            color: Color(.Gray600, opacity: 0.1),
            radius: 8,
            x: 0,
            y: 4
        ).padding(.bottom, 16)
    }
}

#Preview {
    HomeCard()
}
