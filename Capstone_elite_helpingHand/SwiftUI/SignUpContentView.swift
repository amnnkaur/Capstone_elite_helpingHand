//
//  SignUpContentView.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-10.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import SwiftUI

struct SignUpContentView: View {
    
    @State var show = false
    private let initialLaunchKey = "isInitialLaunch"
    
    var body: some View {
        VStack {
//            if show || UserDefaults.standard.bool(forKey: initialLaunchKey){
////                LoginView().transition(.move(edge: .bottom))
//            } else {
                SignUpView( viewControllers: Page.getAll.map({  UIHostingController(rootView: PageView(page: $0) ) }), presentSignupView: {
                    withAnimation {
                        self.show = true
                    }
                    UserDefaults.standard.set(true, forKey: self.initialLaunchKey)
                }).transition(.scale)
            
        }.frame(maxHeight: .infinity)
            .background(Color.backgroundColor)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                UIApplication.shared.endEditing()
        }
    }
}

struct SignUpContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

