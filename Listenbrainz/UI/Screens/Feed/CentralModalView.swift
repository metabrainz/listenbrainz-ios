//
//  CentralModalView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 01/07/24.
//

import SwiftUI


struct CenteredModalView<ModalContent: View>: ViewModifier {
    let modalContent: ModalContent
    @Binding var isPresented: Bool

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> ModalContent) {
        self.modalContent = content()
        self._isPresented = isPresented
    }

    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isPresented ? 3 : 0)

            if isPresented {
                VStack {
                    modalContent
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .overlay(
                            Button(action: {
                                withAnimation {
                                    isPresented = false
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding()
                            },
                            alignment: .topTrailing
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.4))
                .edgesIgnoringSafeArea(.all)
                .transition(.opacity)
            }
        }
    }
}

extension View {
    func centeredModal<ModalContent: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> ModalContent) -> some View {
        self.modifier(CenteredModalView(isPresented: isPresented, content: content))
    }
}

