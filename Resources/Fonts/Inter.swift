import SwiftUI

enum FontWeight {
    case light
    case regular
    case medium
    case semiBold
    case bold
    case black
    case extraLight
    case extraBold
    case thin

}

extension Font {
    static let interFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .thin:
            return Font.custom("InterVariable-Thin", size: size)
        case .extraLight:
            return Font.custom("InterVariable-ExtraLight", size: size)
        case .light:
            return Font.custom("InterVariable-Light", size: size)
        case .medium:
            return Font.custom("InterVariable-Medium", size: size)
        case .semiBold:
            return Font.custom("InterVariable-SemiBold", size: size)
        case .bold:
            return Font.custom("InterVariable-Bold", size: size)
        case .extraBold:
            return Font.custom("InterVariable-ExtraBold", size: size)
        case .black:
            return Font.custom("InterVariable-Black", size: size)
        case .regular:
            return Font.custom("InterVariable", size: size)
       
        }
    }
}

struct TextStyle {
    let size: CGFloat
    let lineHeight: CGFloat
    let weight: FontWeight
    
    static func display2xl(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 72, lineHeight: 90, weight: weight)
    }
    
    static func displayXl(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 60, lineHeight: 72, weight: weight)
    }
    
    static func displayLg(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 48, lineHeight: 60, weight: weight)
    }
    
    static func displayMd(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 36, lineHeight: 44, weight: weight)
    }
    
    static func displaySm(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 30, lineHeight: 38, weight: weight)
    }
    
    static func displayXs(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 24, lineHeight: 32, weight: weight)
    }
    
    static func textXl(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 20, lineHeight: 30, weight: weight)
    }
    
    static func textLg(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 18, lineHeight: 28, weight: weight)
    }
    
    static func textMd(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 16, lineHeight: 24, weight: weight)
    }
    
    static func textSm(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 14, lineHeight: 20, weight: weight)
    }
    
    static func textXs(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 12, lineHeight: 18, weight: weight)
    }
    
    static func textXss(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 10, lineHeight: 18, weight: weight)
    }
    
    static func tiny(_ weight: FontWeight = .regular) -> TextStyle {
        TextStyle(size: 8, lineHeight: 10, weight: weight)
    }
}


extension Text {
    func style(_ textStyle: TextStyle) ->  Text {
            self.interFont(textStyle.weight, textStyle.size)
//                .lineSpacing(textStyle.lineHeight - textStyle.size)
        }
    func interFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.interFont(fontWeight ?? .regular, size ?? 16))
    }
}
