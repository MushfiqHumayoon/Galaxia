//
//  AppConstants.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

var deviceHasNotch = false // this will set from Scene delegate

typealias tapHandler = (() -> Void)

enum ColorTheme {
    case light, dark
}

enum AnimationDirection {
    case left, right
}

// MARK: - Custom Fonts
struct AppFont {
    static let appFontName = "Inter"
    static let fontBlack = "\(appFontName)-Black"
    static let fontBold = "\(appFontName)-Bold"
    static let fontExtraLight = "\(appFontName)-ExtraLight"
    static let fontLight = "\(appFontName)-Light"
    static let fontRegular = "\(appFontName)-Regular"
    static let fontSemiBold = "\(appFontName)-SemiBold"
}


struct ChipData {
    var image: UIImage
    var label: String
}

let dummyChips = [ChipData(image: .kmIcon, label: "139,820 KM"),
                  ChipData(image: .kgIcon, label: "1.898 × 10^27 KG"),
                  ChipData(image: .bagIcon, label: "1 large. "),
                  ChipData(image: .usersIcon, label: "8 passengers")]
