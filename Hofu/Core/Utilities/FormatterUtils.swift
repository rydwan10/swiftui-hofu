//
//  FormatterUtils.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 05/03/25.
//

import Foundation

extension Numeric where Self: CVarArg {
    func formatRupiah() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","

        guard let formattedNumber = formatter.string(for: self) else {
            return "Rp0,-"
        }

        return "Rp\(formattedNumber)"
    }
}
