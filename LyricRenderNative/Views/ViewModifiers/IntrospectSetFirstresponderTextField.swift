//
//  IntrospectSetFirstresponderTextField.swift
//  LyricRenderNative
//
//  Created by Jonathan Yataco  on 4/25/21.
//

import SwiftUI

struct IntrospectSetFirstResponderTextField: ViewModifier {
    @State var isFirstResponderSet = false
    
    func body(content: Content) -> some View {
        content
            .introspectTextField { textField in
                if self.isFirstResponderSet == false {
                    textField.becomeFirstResponder()
                    self.isFirstResponderSet = true
                }
            }
    }
}
