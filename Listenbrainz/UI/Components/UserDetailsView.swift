//
//  UserDetailsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 04/12/23.
//


import SwiftUI

struct UserDetailsView: View {

  // MARK: - PROPERTIES
  @AppStorage("isOnboarding") var isOnboarding: Bool?
  @AppStorage("userToken") private var userToken: String = ""
  @AppStorage("userName") private var userName: String = ""
  var isGetStartedButtonEnabled: Bool {
          return !userName.isEmpty && !userToken.isEmpty
      }

  var body: some View {
    VStack {
      Spacer()

      HStack {
        Text("User Name")
          .font(.title)
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
      }

      VStack {
        TextField("User Name", text: $userName)
          .font(.system(size: 18))

      }
      .padding()
      .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.7)))

      HStack {
        Text("User Token")
          .font(.title)
          .fontWeight(.bold)
          .padding(.top)
          .padding(.leading)
        Spacer()
      }

      VStack {
        TextField("User Token", text: $userToken)
          .font(.system(size: 18))
      }
      .padding()
      .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.7)))

      Text("Enter User Token from https://listenbrainz.org/profile/")
        .font(.callout)
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
        .padding(.horizontal)
        .padding(.bottom, 20)

      Spacer()

      Button {
        isOnboarding = false
      } label: {
        Text("Get Started")
          .font(.headline)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.color_2.opacity(0.7))
          .foregroundColor(.white)
          .cornerRadius(20)
      }
      .disabled(!isGetStartedButtonEnabled)

      Spacer()
    }
    .padding()
  }
}

struct UserDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    UserDetailsView()
  }
}
