//
//  RegisterView.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-11.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var model: ModelView

    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("workplace")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is $\(self.model.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }

    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(model) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            if let decodedOrder = try? JSONDecoder().decode(ModelView.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(ModelView.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(model: ModelView())
    }
}
