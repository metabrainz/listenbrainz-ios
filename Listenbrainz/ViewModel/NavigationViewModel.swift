//
//  NavigationViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 21/08/24.
//

import SwiftUI

class UserSelection: ObservableObject {
    @Published var selectedUserName: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

    func selectUserName(_ username: String) {
        if username.isEmpty {
            selectedUserName = userName
        } else if selectedUserName != username {
            selectedUserName = username
        }
    }
}



