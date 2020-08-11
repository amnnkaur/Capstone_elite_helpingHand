//
//  PageView.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-10.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import SwiftUI

struct PageView: View {
    
    var page = Page.getAll.first!
    
    let txtFields = [TextField(Page.getAll.first!.placeholder[0], text: Binding<String>.constant("")),
                TextField(Page.getAll.first!.placeholder[1], text: Binding<String>.constant("")),
                TextField(Page.getAll.first!.placeholder[2], text: Binding<String>.constant("")),
                TextField(Page.getAll.first!.placeholder[3], text: Binding<String>.constant("")),
                TextField(Page.getAll.first!.placeholder[4], text: Binding<String>.constant(""))]
    
    var body: some View {
            VStack{
                Image(page.image)
                VStack{
                    
                    Text(page.heading).font(.title).bold().layoutPriority(1).multilineTextAlignment(.center)
                
                    ForEach((0...page.noOfFields), id: \.self){ txtField in TextField(self.page.placeholder[txtField], text: Binding<String>.constant(""))
                    }
                    
                }.padding()
            }
        
    }
}


struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
