//
//  SignUpFormView.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-11.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//


import SwiftUI

struct SignUpFormView: View {
    @ObservedObject var model = ModelView()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $model.type) {
                        ForEach(0..<ModelView.types.count, id: \.self) {
                            Text(ModelView.types[$0])
                        }
                    }

                    Stepper(value: $model.quantity, in: 3...20) {
                        Text("Number of cakes: \(model.quantity)")
                    }
                }

                Section {
                    Toggle(isOn: $model.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }

                    if model.specialRequestEnabled {
                        Toggle(isOn: $model.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $model.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }

                Section {
                    NavigationLink(destination: PersnalInfoView(model: model)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct SignUpFormView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFormView()
    }
}
