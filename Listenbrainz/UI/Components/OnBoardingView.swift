import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject var theme: Theme
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Welcome To ListenBrainz")
                .font(.system(size: 48, weight: .semibold))
                .padding(.bottom)
            
            Spacer()
            
            AdaptiveImage(
                light: Image("listenBrainzLight"),
                dark: Image("listenBrainzDark")
            )
            
            Spacer()
            
            NavigationLink(
                destination: UserDetailsView()
                    .environmentObject(theme)
            ) {
                Text("Continue")
                    .font(.headline)
            }
            .navigationBarHidden(true)
            
            
            Spacer()
        }
    }
}

#Preview{
    OnBoardingView()
}

