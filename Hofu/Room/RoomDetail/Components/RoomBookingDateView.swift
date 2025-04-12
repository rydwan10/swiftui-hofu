//
//  RoomBookingDateView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/03/25.
//

import SwiftUI

struct RoomBookingDateView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var checkInDate: Date = .init()
    @State private var showCheckInDatePicker: Bool = false

    @State private var checkOutDate: Date = Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date()
    @State private var showCheckOutDatePicker: Bool = false

    @Binding var isShowingSheetDetailRoom: Bool
    @State var isShowRoomCheckout: Bool = false

    @State var checkInDateCalenderId: UUID = .init()
    @State var checkOutDateCalenderId: UUID = .init()

    @EnvironmentObject var routeManager: RouteManager

    // Minimum and maximum date constraints
    private var minimumCheckInDate: Date {
        return Date() // Cannot select dates in the past
    }

    private var minimumCheckOutDate: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: checkInDate) ?? checkInDate
    }

    var totalPrice: String {
        let days = Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate).day ?? 0
        let basePrice = 5000000 // Contoh harga per malam
        let discount = 0.1 // 10%
        let tax = 0.1 // 10%

        let subTotal = Double(days) * Double(basePrice)
        let discountedPrice = subTotal * (1 - discount)
        let finalPrice = discountedPrice * (1 + tax)

        return finalPrice.formatRupiah()
    }

    private var numberOfNights: Int {
        Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate).day ?? 0
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Check-In Date:")
                            .style(.textMd(.regular))
                        Spacer()
                        Button(action: {
                            showCheckInDatePicker = true
                        }, label: {
                            Image(systemName: "calendar")
                            Text(checkInDate, style: .date)
                        })
                        .popover(isPresented: $showCheckInDatePicker) {
                            DatePicker(
                                "Select check-in date",
                                selection: $checkInDate,
                                in: minimumCheckInDate...,
                                displayedComponents: .date
                            )
                            .datePickerStyle(.graphical)
                            .padding()
                            .frame(width: 365, height: 365)
                            .presentationCompactAdaptation(.popover)
                        }
                        .onChange(of: checkInDate) { _, newValue in
                            // Automatically adjust check-out date if needed
                            if newValue >= checkOutDate {
                                checkOutDate = Calendar.current.date(byAdding: .day, value: 1, to: newValue) ?? newValue
                            }
                            showCheckInDatePicker = false
                        }
                    }

                    HStack {
                        Text("Check-Out Date:")
                            .style(.textMd(.regular))
                        Spacer()
                        Button(action: {
                            showCheckOutDatePicker = true
                        }, label: {
                            Image(systemName: "calendar")
                            Text(checkOutDate, style: .date)
                        })
                        .popover(isPresented: $showCheckOutDatePicker) {
                            DatePicker(
                                "Select check-out date",
                                selection: $checkOutDate,
                                in: minimumCheckOutDate...,
                                displayedComponents: .date
                            )
                            .datePickerStyle(.graphical)
                            .padding()
                            .frame(width: 365, height: 365)
                            .presentationCompactAdaptation(.popover)
                        }
                        .onChange(of: checkOutDate) { _, _ in
                            showCheckOutDatePicker = false
                        }
                    }

                    Divider()

                    // Room Details Section (unchanged)
                    HStack {
                        Image("Sakura")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedCorner(radius: 12, corners: [.bottomLeft, .bottomRight, .topRight, .topLeft])
                            )
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Room 1")
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text("Price: $200 per night")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }

                    Divider()

                    // Terms and Conditions Section (unchanged)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Terms and Conditions")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("1. Check-in time is 2 PM.\n2. Check-out time is 11 AM.\n3. Cancellation policy applies.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }

                    Divider()

                    // Pricing Details
                    HStack {
                        Text("Price (\(numberOfNights) \(numberOfNights == 1 ? "night" : "nights"))")
                            .style(.textMd(.semiBold))
                        Spacer()
                        Text(5000000.formatRupiah())
                    }
                    HStack {
                        Text("Discount")
                            .style(.textMd(.semiBold))
                        Spacer()
                        Text("10%")
                    }
                    HStack {
                        Text("Tax")
                            .style(.textMd(.semiBold))
                        Spacer()
                        Text("10%")
                    }

                    Divider()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total Price")
                                .style(.textLg(.semiBold))
                            Text("after tax")
                                .style(.textMd())
                        }

                        Spacer()
                        Text(totalPrice)
                            .style(.textLg(.semiBold))
                    }
                }
                .padding()
            }
            .navigationTitle("Select Booking Dates")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    HofuOutlineButton(
                        title: "Add to cart",
                        onPressed: {},
                        isFullWidth: true
                    )
                    HofuButton(
                        title: "Checkout",
                        onPressed: {
                            isShowRoomCheckout = true
//                            dismiss()
//                            isShowingSheetDetailRoom = false
//                            routeManager.navigate(to: .checkoutRoom)
                        },
                        isFullWidth: true
                    )
                }

                .padding(16)
                .border(width: 2, edges: [.top], color: .gray100)
                .background(.gray25)
            }.sheet(isPresented: $isShowRoomCheckout) {
                RoomCheckoutView()
                    .padding(.top, 24)
                    .presentationDragIndicator(.visible)
                    .background(.gray50)
            }
        }
    }
}

#Preview {
    @Previewable @State var isShowingSheetDetailRoom = false
    RoomBookingDateView(isShowingSheetDetailRoom: $isShowingSheetDetailRoom)
        .environmentObject(RouteManager())
}
