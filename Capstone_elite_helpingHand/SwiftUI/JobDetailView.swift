//
//  JobDetailView.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-10.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//
import SwiftUI

//MARK: - Detail View -
struct JobDetailView: View {
    
    var job: JobResults?
        var body: some View {
            
            SpecificJobView(job: job ?? JobResults.init(id: "", type: "", url: "", createdAt: "", company: "", companyUrl: "", location: "", title: "", welcomeDescription: "", howToApply: "", companyLogo: ""))
        }
    }
    
    struct JobDetailView_Previews: PreviewProvider {
        static var previews: some View {
            JobDetailView(job: JobResults.init(id: "", type: "", url: "", createdAt: "", company: "", companyUrl: "", location: "", title: "", welcomeDescription: "", howToApply: "", companyLogo: ""))
            
        }
    }
    
    
    struct SpecificJobView : View {
        var job: JobResults
        @State var color = 0
        @State var height = UIScreen.main.bounds.height
        @State var width = UIScreen.main.bounds.width
        
        var body: some View{
            
        VStack{
                
                ZStack(alignment: .top){
                    
                    VStack{
                        
                        Image(self.color == 0 ? "lamp1" : "lamp2")
                        .resizable()
                        .frame(height: 300)
                        
                        
                        HStack(spacing: 20){
                            
                            Button(action: {
                                
                                self.color = 0
                                
                            }) {
                                
                                VStack(spacing: 8){
                                    
                                    ZStack{
                                        
                                        Circle()
                                            .fill(Color.orange)
                                            .frame(width: 20, height: 20)
                                        
                                        Circle()
                                            .stroke(self.color == 0 ? Color.white : Color.clear, lineWidth: 2)
                                            .frame(width: 30, height: 30)
                                    }
                                    
                                }
                            }
                            
                            Button(action: {
                                
                                self.color = 1
                                
                            }) {
                                
                                VStack(spacing: 8){
                                    
                                    ZStack{
                                        
                                        Circle()
                                            .fill(Color.yellow)
                                            .frame(width: 20, height: 20)
                                        
                                        Circle()
                                            .stroke(self.color == 1 ? Color.white : Color.clear, lineWidth: 2)
                                            .frame(width: 30, height: 30)
                                    }
                                    
            
                                }
                            }
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 10)
                    }
                    
                    HStack{
                        
//                        Button(action: {
//
//                        }) {
//
//                            Image("back")
//                                .renderingMode(.original)
//                                .padding()
//                        }
//                        .padding(.leading, 10)
//                        .padding(.top, 20)
//
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                         
                            Image("message")
                                .renderingMode(.original)
                                .padding(0)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, self.height > 800 ? 15 : 10)
                        .background(Color.white)
                        .clipShape(CustomShape(corner: .bottomLeft, radii: self.height > 800 ? 35 : 30))
                    }
                    
                }
                .background(self.color == 0 ? Color.orange : Color.yellow)
                .clipShape(CustomShape(corner: .bottomLeft, radii: 55))
                
                ScrollView(self.height > 800 ? .init() : .vertical, showsIndicators: false) {
                    
                    VStack{
                        
                        HStack{
                            
                            Text(job.title)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }) {
                                
                                Image("heart")
                                    .renderingMode(.original)
                                    .padding()
                            }
                            .background(self.color == 0 ? Color.orange : Color.yellow)
                            .clipShape(Circle())
                            
                        }
                        .padding(.horizontal, 35)
                        .padding(.top,25)
                        
                        
                        Text(job.welcomeDescription ?? "No description found")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 30)
                            .padding(.top,20)
                        
                        Spacer(minLength: 0)
                        
                        HStack(spacing: 10){
                            
                            Button(action: {
                                
                            }) {
                                
                                VStack{
                                    
                                    Image("mat1")
                                        .renderingMode(.original)
                                    
                                    Text(job.type)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                                .padding()
                            }
                            .background(Color.black.opacity(0.06))
                            .cornerRadius(12)
                            
                            Button(action: {
                                
                            }) {
                                
                                VStack{
                                    
                                    Image("mat2")
                                        .renderingMode(.original)
                                    
                                    Text(job.company)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                                .padding()
                            }
                            .background(Color.black.opacity(0.06))
                            .cornerRadius(12)
                            
                            Button(action: {
                                
                            }) {
                                
                                VStack{
                                    
                                    Image("mat3")
                                        .renderingMode(.original)
                                    
                                    Text(job.createdAt)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                                .padding()
                            }
                            .background(Color.black.opacity(0.06))
                            .cornerRadius(12)
                            
                            Button(action: {
                                
                            }) {
                                
                                VStack{
                                    
                                    Image("mat4")
                                        .renderingMode(.original)
                                    
                                    Text(job.location ?? "No Location Found")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                                .padding()
                            }
                            .background(Color.black.opacity(0.06))
                            .cornerRadius(12)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 25)
                        
                        Spacer(minLength: 0)
                    }
                }
                
                HStack{
                    
                    Text("$12.99")
                        .foregroundColor(.black)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 35)
                        .padding(.bottom,25)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        
                        Text("Id: " + job.id)
                            .foregroundColor(.black)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 35)
                    }
                    .background(self.color == 0 ? Color.orange : Color.yellow)
                    .clipShape(CustomShape(corner: .topLeft, radii: 55))
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
            .animation(.default)
        
        }
    }

    
//    class Host : UIHostingController<ContentView> {
//
//        override var prefersHomeIndicatorAutoHidden: Bool{
//
//            return true
//        }
//    }
    
    /*

    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ZStack {
                Image("workplace")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .overlay(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.4), Color.clear]), startPoint: .top, endPoint: .bottom))
                
                Circle()
                    .foregroundColor(.secondary)
                    .frame(width: 72)
                    .offset(x: 0, y: 140)
                    .overlay(
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 72))
                            .offset(x: 0, y: 140)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            }
            
            VStack {
                Text(job.title)
                    .font(.title)
                    .bold()
                
                Text(job.company)
                Text(job.type)
            }
            .padding(.top, 55)
        }
        .navigationBarItems(trailing: Button(action: shareAction, label: {
            Image(systemName: "square.and.arrow.up")
        }))
        .edgesIgnoringSafeArea(.top)
    }
    
    func shareAction() {
        print(job.url)
    }
 */
