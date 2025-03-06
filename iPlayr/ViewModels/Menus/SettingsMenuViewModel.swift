//  SettingsMenuViewModel.swift
//  iPlayr
//
//  Created by Kilian Balaguer on 05/03/2025.
//

import Combine
import SwiftUI

class SettingsMenuViewModel: MenuViewModel, ObservableObject {
    lazy var menuOptions = [
        MenuOption(title: "About", nextMenu: AnyView(AboutView()), onSelect: showAbout),
        MenuOption(title: "Devs", nextMenu: AnyView(DevsView()), onSelect: showDevs)
    ]

    @Published var currentIndex: Int = 0
    var sinks = Set<AnyCancellable>()

    private func showAbout() {
        let dict: [String: AnyView] = ["view": AnyView(AboutView())]
        let name = MyNotifications.showFullScreenView.rawValue
        let notification = Notification(name: .init(name), userInfo: dict)
        NotificationCenter.default.post(notification)
    }

    private func showDevs() {
        let dict: [String: AnyView] = ["view": AnyView(DevsView())]
        let name = MyNotifications.showFullScreenView.rawValue
        let notification = Notification(name: .init(name), userInfo: dict)
        NotificationCenter.default.post(notification)
    }

    func prevTick() {
        if currentIndex != 0 {
            currentIndex -= 1
            ClickWheelService.shared.playTick()
        }
    }

    func nextTick() {
        if currentIndex != menuOptions.count - 1 {
            currentIndex += 1
            ClickWheelService.shared.playTick()
        }
    }

    func prevClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
    }

    func nextClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
    }

    func menuClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
    }

    func playPauseClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
    }

    func centerClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()

        if let onSelect = menuOptions[currentIndex].onSelect {
            onSelect()
        }
    }

    func startClickWheelSubscriptions(
        prevTick: (() -> Void)? = nil,
        nextTick: (() -> Void)? = nil,
        prevClick: (() -> Void)? = nil,
        nextClick: (() -> Void)? = nil,
        menuClick: (() -> Void)? = nil,
        playPauseClick: (() -> Void)? = nil,
        centerClick: (() -> Void)? = nil
    ) {
        ClickWheelService.shared.prevTick
            .receive(on: RunLoop.main)
            .sink {
                self.prevTick()
                prevTick?()
            }
            .store(in: &sinks)

        ClickWheelService.shared.nextTick
            .receive(on: RunLoop.main)
            .sink {
                self.nextTick()
                nextTick?()
            }
            .store(in: &sinks)

        ClickWheelService.shared.prevClick
            .receive(on: RunLoop.main)
            .sink {
                self.prevClick()
                prevClick?()
            }
            .store(in: &sinks)

        ClickWheelService.shared.nextClick
            .receive(on: RunLoop.main)
            .sink {
                self.nextClick()
                nextClick?()
            }
            .store(in: &sinks)

        ClickWheelService.shared.menuClick
            .receive(on: RunLoop.main)
            .sink {
                self.menuClick()
                menuClick?()
            }
            .store(in: &sinks)

        ClickWheelService.shared.playPauseClick
            .receive(on: RunLoop.main)
            .sink {
                self.playPauseClick()
                playPauseClick?()
            }
            .store(in: &sinks)

        ClickWheelService.shared.centerClick
            .receive(on: RunLoop.main)
            .sink {
                self.centerClick()
                centerClick?()
            }
            .store(in: &sinks)
    }
}
