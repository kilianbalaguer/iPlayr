//
//  OnboardingDeviceDisplay.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas on 2/20/21.
//

import SwiftUI

struct OnboardingDeviceDisplay: View {
    @StateObject private var vm = DisplayViewModel()
    @State private var move: Bool = false
    private let animateCover: Bool = false
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    StatusBar()
                    MainMenuOnboarding()
                }

                Image("abbeyRoad")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.width / 2)
                    .frame(maxHeight: .infinity)
                    .if(animateCover) {
                        $0.offset(x: coverOffset(for: proxy.width))
                    }
                    .clipped()
                    .overlay(shadowOverlay)
                    .if(animateCover) {
                        $0.onAppear(perform: startCoverAnimation)
                    }
            }.tRoundCorners()
                .overlay(thickBorder)
                .onAppear(perform: vm.startListeningToFullScreenNotifications)
        }
    }

    private var shadowOverlay: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.4)]), startPoint: .center, endPoint: .leading)
    }

    private var thickBorder: some View {
        CustomRoundedRectangle(radius: 8)
            .stroke(Color.black, lineWidth: 4)
    }

    private func coverOffset(for width: CGFloat) -> CGFloat {
        move ? -width / 16 : width / 16
    }

    private func startCoverAnimation() {
        withAnimation(Animation.linear(duration: 8).repeatForever(autoreverses: true)) {
            move = true
        }
    }
}

struct MainMenuOnboarding: View {
    @StateObject private var vm = MainMenuViewModel()
    @State private var childrenShowing = Array(repeating: false, count: 12) // dangerous, yes.
    init() {
        childrenShowing = Array(repeating: false, count: vm.menuOptions.count)
    }

    var body: some View {
        ZStack {
            Color.systemBackground
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0 ..< vm.menuOptions.count, id: \.self) { i in

                    vm.row(at: i)
                }

                Spacer()
            }
            .font(.headline)
        }
    }

    private func startClickWheelSubscriptions() {
        vm.startClickWheelSubscriptions(
            prevTick: nil,
            nextTick: nil,
            prevClick: nil,
            nextClick: { childrenShowing[vm.currentIndex] = true },
            menuClick: nil,
            playPauseClick: nil,
            centerClick: { childrenShowing[vm.currentIndex] = true })
    }

    private func stopClickWheelSubscriptions() {
        vm.stopClickWheelSubscriptions()
    }
}
