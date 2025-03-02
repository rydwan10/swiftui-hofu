//
//  HotelHeaderImage.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 01/03/25.
//

import SwiftUI

struct HotelHeaderImage: View {
    let imageName: String
    let height: CGFloat

    init(imageName: String, height: CGFloat = 328) {
        self.imageName = imageName
        self.height = height
    }

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(height: height)
            .clipped()
            .padding(.bottom, 16)
    }
}


#Preview {
    HotelHeaderImage(imageName: "Sakura")
}
