//  SettingsMenu.swift
//  iPlayr
//
//  Created by Kilian Balaguer on 05/03/2025.
//

import SwiftUI

struct SettingsMenu: View {
    @StateObject private var vm = SettingsMenuViewModel()
    @Environment(\.presentationMode) private var presentationMode
    @State private var childrenShowing = Array(repeating: false, count: 12) // Adjusted dynamically

    init() {
        let count = vm.menuOptions.count
        childrenShowing = Array(repeating: false, count: count)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0 ..< vm.menuOptions.count, id: \.self) { i in
                NavigationLink(destination: vm.destination(at: i), isActive: $childrenShowing[i], label: {
                    vm.row(at: i)
                })
            }
            Spacer()
        }
        .disabled(true)
        .font(.headline)
        .navigationBarHidden(true)
        .onAppear(perform: startClickWheelSubscriptions)
        .onDisappear(perform: stopClickWheelSubscriptions)
    }

    private func startClickWheelSubscriptions() {
        vm.startClickWheelSubscriptions(
            prevTick: nil,
            nextTick: nil,
            prevClick: nil,
            nextClick: nil,
            menuClick: { presentationMode.wrappedValue.dismiss() },
            playPauseClick: nil,
            centerClick: nil
        )
    }

    private func stopClickWheelSubscriptions() {
        vm.stopClickWheelSubscriptions()
    }
}
