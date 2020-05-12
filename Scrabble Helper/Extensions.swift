//
//  Extensions.swift
//  Scrabble Helper
//
//  Created by Eric Jorgensen on 5/8/20.
//  Copyright © 2020 Eric Jorgensen. All rights reserved.
//

import Foundation
import SwiftUI

// extension for keyboard to dismiss
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
