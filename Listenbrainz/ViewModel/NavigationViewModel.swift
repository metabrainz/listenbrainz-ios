//
//  NavigationViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 21/08/24.
//

import SwiftUI

class UserSelection: ObservableObject {
    @Published var selectedUserName: String = ""

    func selectUserName(_ username: String) {
        selectedUserName = username
    }

    func resetUserName() {
        selectedUserName = ""
    }
}




