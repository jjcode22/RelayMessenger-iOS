//
//  AuthLoginModel.swift
//  RelayMessenger
//
//  Created by JJ on 14/03/24.
//

import Foundation
import UIKit

protocol AuthLoginModel {
    var formIsValid: Bool {get}
    var backgroundColor: UIColor {get}
    var buttonTitleColor: UIColor {get}
}
