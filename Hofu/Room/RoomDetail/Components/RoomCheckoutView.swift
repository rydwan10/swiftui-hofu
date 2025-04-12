//
//  RoomCheckoutView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/03/25.
//

import SwiftUI

struct RoomItem: Identifiable {
    let id = UUID()
    let name: String
    let nights: Int
    let pricePerNight: Double
    let discount: Double
    let tax: Double

    var subtotal: Double {
        return Double(nights) * pricePerNight
    }

    var total: Double {
        let discountedPrice = subtotal * (1 - discount)
        return discountedPrice * (1 + tax)
    }
}

struct RoomCheckoutView: View {
    @Environment(\.dismiss) private var dismiss
    var formRoute: Bool = false

    let roomItems: [RoomItem] = [
        RoomItem(name: "Deluxe Suite", nights: 3, pricePerNight: 5000000, discount: 0.1, tax: 0.1),
        RoomItem(name: "Executive Suite", nights: 2, pricePerNight: 7000000, discount: 0.05, tax: 0.1),
        RoomItem(name: "Executive Suite", nights: 2, pricePerNight: 7000000, discount: 0.05, tax: 0.1),
        RoomItem(name: "Executive Suite", nights: 2, pricePerNight: 7000000, discount: 0.05, tax: 0.1),
        RoomItem(name: "Executive Suite", nights: 2, pricePerNight: 7000000, discount: 0.05, tax: 0.1),
    ]

    var totalPrice: Double {
        roomItems.reduce(0) { $0 + $1.total }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Room List
            ScrollView {
                YourRoomsView(
                    roomItems: roomItems
                )
                PaymentMethodView()
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 16)
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .background(.gray50)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Checkout")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    RoomCheckoutFooterView(
                        price: totalPrice.formatRupiah(),
                        onCheckoutPressed: {
                            dismiss()
                            print("Checkout pressed for hotel ")
                        }
                    )
                }
                if !formRoute {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.white, for: .bottomBar)
            .toolbarBackgroundVisibility(.visible, for: .bottomBar)
        }
    }
}

struct RoomCheckoutFooterView: View {
    let price: String
    let taxInfo: String
    var onCheckoutPressed: () -> Void

    init(
        price: String,
        taxInfo: String = "Includes tax and discounts",
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
                    .style(.textXs(.regular))
                    .foregroundStyle(.gray400)
            }
            Spacer()
            HofuButton(title: "Proceed", onPressed: onCheckoutPressed)
        }
        .padding(.top, 14)
        .padding(.horizontal, 16)
    }
}

struct YourRoomsView: View {
    var roomItems: [RoomItem] = []

    var body: some View {
        HofuCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("Your Rooms")
                    .style(.textSm(.semiBold))

                ForEach(roomItems) { item in

                    VStack {
                        HStack(alignment: .top) {
                            Image("Sakura")
                                .resizable()
                                .frame(width: 82, height: 82)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 12))
                                .padding(.trailing, 8)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                    .style(.textMd(.semiBold))

                                HStack {
                                    Text("Price")
                                        .style(.textSm(.regular))
                                        .foregroundStyle(.gray500)
                                    Spacer()
                                    Text(item.subtotal.formatRupiah())
                                        .style(.textSm(.regular))
                                        .foregroundStyle(.gray500)
                                }
                                HStack {
                                    Text("Discount")
                                        .style(.textSm(.regular))
                                        .foregroundStyle(.gray500)
                                    Spacer()
                                    Text("15%")
                                        .style(.textSm(.regular))
                                        .foregroundStyle(.gray500)
                                }
                                HStack {
                                    Text("Tax")
                                        .style(.textSm(.regular))
                                        .foregroundStyle(.gray500)
                                    Spacer()
                                    Text("\(item.tax * 100, specifier: "%.0f")%")
                                        .style(.textSm(.regular))
                                        .foregroundStyle(.gray500)
                                }
                                VStack {
                                    HStack {
                                        Text("Total (\(item.nights) \(item.nights > 1 ? "nights" : "night"))")
                                            .style(.textSm(.semiBold))

                                        Spacer()
                                        Text(item.total.formatRupiah())
                                            .style(.textSm(.semiBold))
                                    }
                                }.padding(.bottom, 8)
                            }
                        }
                        if item.id != roomItems.last?.id {
                            Divider()
                        }
                    }
                }
            }
        }
    }
}

struct PaymentMethodView: View {
    enum PaymentMethodType: String, CaseIterable, Identifiable {
        case creditCard = "Credit Card"
        case eWallet = "E-Wallet"
        case virtualAccount = "Virtual Account"

        var id: String { rawValue } // Conforms to Identifiable
    }

    @State private var selectedPaymentMethod: PaymentMethodType = .virtualAccount

    private let virtualAccountList: [(String, String)] = [
        ("BCA", "bank_bca"),
        ("BRI", "bank_bri"),
        ("BNI", "bank_bni"),
        ("Mandiri", "bank_mandiri"),
    ]

    private let ccList: [(String, String)] = [
        ("MasterCard", "cc_mastercard"),
        ("Visa", "cc_visa"),
        ("American Express", "cc_amex"),
    ]

    private let ewalletList: [(String, String)] = [
        ("OVO", "ewallet_ovo"),
        ("Gopay", "ewallet_gopay"),
        ("Dana", "ewallet_dana"),
        ("LinkAja", "ewallet_linkaja"),
    ]

    // Add this property to track individual expansions
    @State private var expandedPaymentMethod: PaymentMethodType?

    var body: some View {
        HofuCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("Choose Payment Method")
                    .font(.headline)

                // Payment Methods List
                ForEach(PaymentMethodType.allCases) { method in
                    VStack(alignment: .leading, spacing: 8) {
                        // Radio Button for Payment Method
                        Button(action: {
                            withAnimation(.linear(duration: 0.3)) {
                                selectedPaymentMethod = method

                                // Toggle expansion with animation
                                if expandedPaymentMethod == method {
                                    expandedPaymentMethod = nil
                                } else {
                                    expandedPaymentMethod = method
                                }
                            }
                        }) {
                            HStack {
                                Image(systemName: selectedPaymentMethod == method ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedPaymentMethod == method ? .blue : .gray)
                                Text(method.rawValue)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                Spacer()

//                                // Add a chevron that rotates
//                                Image(systemName: "chevron.down")
//                                    .rotationEffect(.degrees(expandedPaymentMethod == method ? 180 : 0))
//                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)

                        // Supported Items Based on Selected Method
                        if selectedPaymentMethod == method {
                            VStack(alignment: .leading, spacing: 8) {
                                // Content remains the same but wrapped in animation modifiers
                                if method == .virtualAccount {
                                    PaymentOptionListView(title: "Supported VA Banks", options: virtualAccountList)
                                } else if method == .creditCard {
                                    PaymentOptionListView(title: "Supported Credit Cards", options: ccList)
                                } else {
                                    PaymentOptionListView(title: "Supported E-Wallets", options: ewalletList)
                                }
                            }
                            .padding(.leading, 24)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .clipped()
                        }
                    }
                }
            }
            .padding()
        }
        .animation(.spring(response: 0.3, dampingFraction: 1), value: selectedPaymentMethod)
    }

}

struct PaymentOptionListView: View {
    var title: String
    var options: [(String, String)]
    
    @State var selectedOption: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .style(.textSm(.semiBold))

            ForEach(options, id: \.0) { option in
                Button(
                    action: {
                        withAnimation {
                            selectedOption = option.0
                        }
                    }
                ) {
                    HStack(spacing: 12) {
                        Image(option.1)
                            .resizable()
                            .frame(width: 50, height: 35)
                        
                        Text(option.0)
                            .style(.textSm(.semiBold))
                            .foregroundStyle(.gray900)
                        Spacer()
                        if selectedOption == option.0 {
                            Image("ic_check_square")
                                .renderingMode(.template)
                                .foregroundColor(.brand600)
                        }
                        
                    }
                    .padding(.all, 8)
                    .cornerRadius(6)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 6)
                            .strokeBorder(selectedOption == option.0 ? .brand600 : .gray400, lineWidth: 1)
                    )
                    .transition(.scale.combined(with: .opacity))
                }
            }
        }
    }
}

#Preview("Room Checkout View") {
    RoomCheckoutView()
}

#Preview("Your Rooms View") {
    let roomItems: [RoomItem] = [
        RoomItem(name: "Deluxe Suite", nights: 3, pricePerNight: 5000000, discount: 0.1, tax: 0.1),
        RoomItem(name: "Executive Suite", nights: 2, pricePerNight: 7000000, discount: 0.05, tax: 0.1),
        RoomItem(name: "Executive Suite", nights: 2, pricePerNight: 7000000, discount: 0.05, tax: 0.1),
        RoomItem(name: "Executive Suite", nights: 2, pricePerNight: 7000000, discount: 0.05, tax: 0.1),
        RoomItem(name: "Executive Suite", nights: 2, pricePerNight: 7000000, discount: 0.05, tax: 0.1),
    ]
    YourRoomsView(
        roomItems: roomItems
    )
}

#Preview("Payment Method View") {
    PaymentMethodView()
}
