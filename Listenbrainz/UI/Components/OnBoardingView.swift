import SwiftUI

struct OnBoardingView: View {

  var body: some View {
    VStack {
      Spacer()

      Text("Welcome To ListenBrainz")
        .font(.system(size: 48, weight: .semibold))
        .padding(.bottom)

      Spacer()

      AdaptiveImage(light: Image("listenBrainzLight")
                    , dark: Image("listenBrainzDark"))


      Spacer()

      NavigationLink(destination: UserDetailsView()) {
        Text("Next")
          .font(.headline)
      }
      .navigationBarTitle("", displayMode: .inline)
      .navigationBarHidden(true)


      Spacer()
    }
  }
}

struct OnBoardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnBoardingView()
  }
}
