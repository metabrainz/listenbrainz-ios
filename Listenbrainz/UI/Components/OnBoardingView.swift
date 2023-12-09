import SwiftUI

struct OnBoardingView: View {
  @State private var iconsScale: CGFloat = 0.5

  var body: some View {
    VStack {
      Spacer()

      Text("Welcome To ListenBrainz")
        .font(.system(size: 48, weight: .semibold))
        .padding(.bottom)

      Spacer()

      HStack(spacing: -120) {
        Image("secondaryIcon")
          .resizable()
          .scaledToFit()
          .scaleEffect(iconsScale)
          .frame(width: 250 , height: 250 )
          .onTapGesture {
            withAnimation(.easeInOut(duration: 1.0)) {
              iconsScale = 1.0
            }
          }

        Image("primaryIcon")
          .resizable()
          .scaledToFit()
          .scaleEffect(iconsScale)
          .frame(width: 250, height:250)
          .onTapGesture {
            withAnimation(.easeInOut(duration: 1.0)) {
              iconsScale = 1.0
            }
          }
      }

      Spacer()

      NavigationLink(destination: UserDetailsView()) {
        Text("Next")
          .font(.headline)
      }
      .navigationBarTitle("", displayMode: .inline)
      .navigationBarHidden(true)


      Spacer()
    }
    .onAppear {
      withAnimation(.easeInOut(duration: 1.0)) {
        iconsScale = 1.0
      }
    }
  }
}

struct OnBoardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnBoardingView()
  }
}
