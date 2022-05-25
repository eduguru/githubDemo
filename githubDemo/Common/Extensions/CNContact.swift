//
//  CNContact.swift
//  Little Agent
//
//  Created by edwin weru on 28/12/2020.
//

import Foundation
import ContactsUI

extension CNContact {
    
    open func displayName() -> String {
        return givenName + " " + familyName
    }
}
