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
                    SDK.thumbs(key:"LDLGjIR8GzycQCt14yC1SyPGUGuAvrRQtQm9io58dnYOcGRAmo0hO5vVRIizk3Oeu62aktawVDl8r8kMyJT2mkqPjyvUdirLAAoCnKDD0NVQpEt3PfhfH5YFujExi5oh", onLoadFailed: {

                    } )
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
