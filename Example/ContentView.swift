//
//  ContentView.swift
//  Example
//
//  Created by Евгений Егоров on 05.02.2021.
//

import SwiftUI
import WebstoryzSDK

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    Rectangle().frame(width: 200, height: 200, alignment:   .center)
                    
                        SDK.thumbs(key:"NN3gdOhoJHcuI42t7xIFGWdpJ8YwMxkc6W1dlutmYS9C6xdR0fRJHgpZ315ZuUXRMtwu9n2fyjRoaEIvHi2mZtcK87uqVFGudGiIbudrNM7onWcKej78B1WRm65nScdC")
                .padding([.top, .bottom])
                .padding(.bottom, 32)
                    Rectangle().frame(width: 200, height: 200, alignment:   .center)
                    
                }.background(Color.black)
              Text("HW")
            }
            .padding(.leading, 100)
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
