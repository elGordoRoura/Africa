//
//  CenterModifier.swift
//  Africa
//
//  Created by Christopher J. Roura on 10/30/20.
//

import SwiftUI

struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        } //: HSTACK
    }
}
