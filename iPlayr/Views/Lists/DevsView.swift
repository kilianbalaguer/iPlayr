import SwiftUI
import Combine

struct DevsView: View {
    @Environment(\.presentationMode) private var presentationMode  // Add presentationMode
    @StateObject private var viewModel = AboutViewModel()  // View model to handle click wheel subscriptions

    var body: some View {
        VStack(spacing: 0) {
            StatusBar(title: "Developers")

            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Developed by")
                        .font(.title2)
                        .bold()

                    Text("Kilian Balaguer")
                        .font(.headline)

                    Text("Lead Developer & Designer")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            // Start click wheel subscriptions when the view appears
            startClickWheelSubscriptions()
        }
        .onDisappear {
            // Stop subscriptions when the view disappears
            stopClickWheelSubscriptions()
        }
    }

    private func startClickWheelSubscriptions() {
        // Pass presentationMode.wrappedValue.dismiss() to menuClick in the view model
        viewModel.startClickWheelSubscriptions(menuClick: { presentationMode.wrappedValue.dismiss() })
    }

    private func stopClickWheelSubscriptions() {
        // Stop subscriptions
        viewModel.stopClickWheelSubscriptions()
    }
}

struct DevsView_Previews: PreviewProvider {
    static var previews: some View {
        DevsView()
    }
}
