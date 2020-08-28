//
//  LocalAuthManager.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-27.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation
import LocalAuthentication

public class LocalAuthManager: NSObject {

    public static let shared = LocalAuthManager()
    private let context = LAContext()
    private let reason = "Your Request Message"
    private var error: NSError?

    enum BiometricType: String {
        case none
        case touchID
        case faceID
    }

    private override init() {

    }

    // check type of local authentication device currently support
    var biometricType: BiometricType {
        guard self.context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }

        if #available(iOS 11.0, *) {
            switch context.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            @unknown default:
                fatalError()
            }
        } else {
            return self.context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) ? .touchID : .none
        }
    }
}



