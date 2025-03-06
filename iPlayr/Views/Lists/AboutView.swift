import Combine
import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) private var presentationMode // Add presentationMode

    var body: some View {
        VStack(spacing: 0) {
            StatusBar(title: "About")

            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("iPlayr")
                        .font(.title)
                        .bold()

                    Text("iPlayr is a modern music player designed for Apple-style interfaces. Inspired by the classic iPod experience, it integrates seamless navigation and intuitive controls.")

                    Text("Version 1.0.0")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            // Update the subscriptions when AboutView appears
            startClickWheelSubscriptions()
        }
        .onDisappear {
            // Stop the subscriptions when AboutView disappears
            stopClickWheelSubscriptions()
        }
    }

    private func startClickWheelSubscriptions() {
        // Pass presentationMode.wrappedValue.dismiss() to menuClick
        AboutViewModel().startClickWheelSubscriptions(
            menuClick: { presentationMode.wrappedValue.dismiss() }
        )
    }

    private func stopClickWheelSubscriptions() {
        // Stop subscriptions
        AboutViewModel().stopClickWheelSubscriptions()
    }
}
