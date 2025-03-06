//
//  onboardingPage.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas on 2/20/21.
//

import SwiftUI

struct OnboardingPage: View {
    var titleText: String
    var bodyText: String
    var image: String
    
    @State var animate1 = false
    @State var animate2 = false
    @State var animate3 = false
    @State var animate4 = false
    @State var animate5 = false
    @State var animate6 = false
    @Binding var show: Bool
    // @EnvironmentObject var userData: UserData
    let screenSize = UIScreen.main.bounds
    
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    @Binding var nextCount: Int
    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color.systemBackground
                    .ignoresSafeArea(.all)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            animate1 = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            animate2 = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            animate3 = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            animate4 = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            animate5 = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            animate6 = true
                        }
                    }
                VStack {
                    HStack {
                        if animate1 {
                            Text(titleText)
                                .font(.title)
                                .bold()
                                .foregroundColor(Color.primary)
                                .padding(.top, 60)
                                .transition(.opacity)
                                .animation(.easeInOut(duration: 1.5))
                        }
                    }
                    if animate2 {
                        Spacer()
                    }
                    if animate3 {
                        Text(bodyText)
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                  
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.primary)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 1.5))
                    }
                    if animate4 {
                        Spacer()
                    }
                    if animate5 {
                        OnboardingScene(nextCount: $nextCount)
                        // .frame(height: geo.size.height / 3)
                    }
                    if animate6 {
                        Button(action: {
                            // withAnimation(.easeInOut(duration: 0.1)) {
                            nextCount += 1
                            isOnboardingCompleted = true
                            //   }
                            print("next")
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(Color.primary)
                                    .frame(height: 70)
                                Text("Start Listening")
                                    .font(.headline)
                                    .foregroundColor(Color.systemBackground)
                            }.padding()
                        }.padding(.bottom)
                        
                        // Spacer()
                    }
                    // Text("Skip for now")
                    //  .font(.custom("Montserrat-Regular", size: 17))
                    // .foregroundColor(Color.black.opacity(0.5))
                    // .padding(.bottom, 10)
                }
                if nextCount == 1 {
                    OnboardingScene(nextCount: $nextCount)
                        .transition(.opacity)
                }
            }.ignoresSafeArea(.all)
        }
    }
}
