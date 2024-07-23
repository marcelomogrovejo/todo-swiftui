//
//  Color+ColorPalette.swift
//  ListPostsMVP
//
//  Created by Marcelo Mogrovejo on 10/02/2023.
//

import SwiftUI

/**
 Color palette from: https://coolors.co/272727-fed766-009fb7-696773-eff1f3
    - #272727
    - #FED766
    - #009FB7
    - #696773
    - #EFF1F3
*/
extension Color {

    struct Background {
        static let defaultBackgroundColor: Color = Color("bkg-default-color")
    }

    struct Text {
        static let highlitedColor: Color = Color("txt-highlited-color")
        static let defaultColor: Color = Color("txt-default-color")
    }

    struct TextField {
        static let textColor: Color = Color("txt-field-text-color")
        static let placeholderColor: Color = Color("txt-field-placeholder-color")
        static let backgroundColor: Color = Color("txt-field-background-color")
        static let containerBackgrounColor: Color = Color("txt-container-background-color")
    }

    struct Progress {
        static let mainBackgroundColor: Color = Color("prg-main-bkg-color")
        static let backgroundColor: Color = Color("prg-bkg-color")
        static let messageColor: Color = Color("prg-message-color")
    }

    struct Popup {
        static let mainBackgroundColor: Color = Color("pp-main-bkg-color")
        static let backgroundColor: Color = Color("pp-bkg-color")
        static let titleColor: Color = Color("pp-title-color")
        static let messageColor: Color = Color("pp-message-color")
    }

    struct Button {
        static let backgroundColor: Color = Color("btn-bkg-color")
        static let foregroundColor: Color = Color("btn-fgd-color")
        static let removeBackgroundColor: Color = Color("btn-delete-bkg-color")
        static let editBackgroundColor: Color = Color("btn-edit-bkg-color")
    }

    struct NavBar {
        static let backgroundColor: Color = Color("bkg-nav-bar-default-color")
    }

    struct Toggle {
        static let backgroundColor: Color = Color("stch-bkg-color")
    }

}
