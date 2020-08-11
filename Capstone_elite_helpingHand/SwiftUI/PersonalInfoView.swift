//
//  PersonalInfoView.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-11.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import SwiftUI

struct PersnalInfoView: View {
    @ObservedObject var model: ModelView

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $model.name)
                TextField("Street Address", text: $model.streetAddress)
                TextField("City", text: $model.city)
                TextField("Zip", text: $model.zip)
            }

            Section {
                NavigationLink(destination: RegisterView(model: model)) {
                    Text("Check out")
                }
            }
            .disabled(model.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct PersonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PersnalInfoView(model: ModelView())
    }
}
