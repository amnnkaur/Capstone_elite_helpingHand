//
//  SignUpView.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-10.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import SwiftUI

struct SignUpView<Page: View>  : View {
    
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    @State var buttonText = "Next"
    var presentSignupView: (()->()) = {}
    
        
    var body: some View {
       
       return VStack {
        PageViewController(controllers: viewControllers, currentPage: self.$currentPage)
            
            PageIndicator(currentIndex: self.currentPage)
            
           VStack {
                
                Button(action: {
                    if self.currentPage < self.viewControllers.count - 1{
                        self.currentPage += 1
                    } else {
                        self.presentSignupView()
                    }
                }) {
                    HStack {
                        Text(currentPage == viewControllers.count - 1 ? "Get started" : "Next" )
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .accentColor(Color.white)
                            .background(Color("accentColor"))
                            .cornerRadius(30)
                    }.padding()
                }
            }.padding(.vertical)
        }.background(Color.backgroundColor)
    }
}

struct SignUpViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView( viewControllers: Page.getAll.map({  UIHostingController(rootView: PageView(page: $0) )  }))
    }
}


struct PageIndicator: View {
    
    var currentIndex: Int = 0
    var pagesCount: Int = 4
    var onColor: Color = Color.accentColor
    var offColor: Color = Color.offColor
    var diameter: CGFloat = 10
    
    var body: some View {
        HStack{
            ForEach(0..<pagesCount){ i in
                Image(systemName: "circle.fill").resizable()
                    .foregroundColor( i == self.currentIndex ? self.onColor : self.offColor)
                    .frame(width: self.diameter, height: self.diameter)

            }
        }
    }
}

struct PageIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PageIndicator()
    }
}

