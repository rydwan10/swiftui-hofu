//
//  HotelPriceFooter.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 01/03/25.
//

import SwiftUI

struct HotelPriceFooter: View {
    let price: String
    let taxInfo: String
    var onCheckoutPressed: () -> Void

    init(
        price: String,
        taxInfo: String = "per night (include tax)",
        onCheckoutPressed: @escaping () -> Void
    ) {
        self.price = price
        self.taxInfo = taxInfo
        self.onCheckoutPressed = onCheckoutPressed
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(price)
                    .style(.textMd(.semiBold))
                    .foregroundStyle(.gray700)
                Text(taxInfo)
                    .style(.textXss(.semiBold))
            }
            Spacer()
            HofuButton(title: "Check Out", onPressed: onCheckoutPressed)
        }
        .padding(.top, 14)
        .padding(.horizontal, 16)
    }
}

#Preview {
    HotelPriceFooter(
        price: "100.000.000",
        onCheckoutPressed: {
            print("Checkout pressed for hotel 12")
        }
    )
}
