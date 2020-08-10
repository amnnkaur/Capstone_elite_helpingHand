//
//  ContentView.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-10.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        TabView {
            NavigationView {
                VStack {
                    RecentJobsScrollView()
                }
                .edgesIgnoringSafeArea(.top)
                
                RecentJobsScrollView()
            }
//            .tabItem { Image(systemName: "house.fill") }
//            .tag(1)
//
//            Text("Tab Content 2").tabItem { Image(systemName: "bookmark.fill") }
//            .tag(2)
//
//            Text("Tab Content 3").tabItem {
//                Image(systemName: "plus.circle.fill")
//                    .font(.system(size: 33))}
//            .tag(3)
//
//            Text("Tab Content 4").tabItem { Image(systemName: "gear") }
//            .tag(4)
//
//            Text("Tab Content 5").tabItem { Image(systemName: "person.fill") }
//            .tag(5)
//        }
//        .edgesIgnoringSafeArea(.top)
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchTextFieldView: View {
    @State private var search: String = ""
    
    var body: some View {
        TextField("Search jobs", text: $search)
            .padding()
            .background(Color.white)
            .clipShape(Capsule())
            .padding()
            .overlay(SearchIconView())
    }
}

struct SearchIconView: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "magnifyingglass")
                .padding()
        }
        .padding(.trailing)
    }
}

struct SearchButtonsHStackView: View {
    let buttons = [SearchButton(icon: "slider.horizontal.3", label: "Filters"),
                   SearchButton(icon: "mappin.and.ellipse", label: "Location"),
                   SearchButton(icon: "square.grid.2x2.fill", label: "Category")]
    
    var body: some View {
        HStack {
            ForEach(buttons, id: \.self) { button in
                Button(action: self.buttonAction) {
                    HStack {
                        Image(systemName: button.icon)
                        Text(button.label)
                    }
                }
                .accentColor(.white)
                .padding(10)
                .padding(.horizontal, 8)
                .background(Color.black.opacity(0.2))
                .cornerRadius(8)
            }
        }
    }
    
    func buttonAction() {
        print("Hi button!")
    }
}

struct SearchButton: Hashable {
    let icon: String
    let label: String
}

struct SearchJobView: View {
    var body: some View {
        VStack {
            SearchTextFieldView()
            SearchButtonsHStackView()
        }
    }
}

struct RecentJobsScrollView: View {
    @ObservedObject var jobs = NetworkManager()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing)
                SearchJobView()
            }
            .frame(height: 220)
            
            HStack {
                Text("Recent Jobs")
                    .font(.title)
                    .fontWeight(.light)
                
                Spacer()
            }
            .padding()
            
            ForEach(self.jobs.jobReults, id: \.id) { job in
                NavigationLink(destination: JobDetailView(job: job)) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 6)
                            .padding(.horizontal)
                        
                        HStack(alignment: .top) {
                           /* Image(systemName: "dollarsign.circle")
                                .font(.largeTitle)
                                .padding()*/
                            
                            VStack(alignment: .leading) {
                                Text(job.company.capitalizingFirstLetter())
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                
                                Text(job.title)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.black)
                                
                                Text(job.type)
                                    .font(.callout)
                                    .fontWeight(.light)
                                    .foregroundColor(Color.black)
                            }
                            
                            VStack {
                               /* Image(systemName: "bookmark.fill")*/
                                Spacer()
                                Text(job.createdAt.prefix(10))
                                    .font(.footnote)
                            }
                            .padding(.trailing)
                            .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                    
                }
            }
        }
    }
}


