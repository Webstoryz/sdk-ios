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
                    SDK.thumbs(key:"rlvs9F5zNhfTdjSLHdVgcFNDk7aXpAwq3CeXQsHICEIokQYXYJxayMFgD1A6vmmtMfsxQFmLXRGj1b9HN2nbW6CWjtL75q75WWHxfqXdtImYaC9nG2OG5VVGuoUR2YJJ", onLoadFailed: {
                    } )
                }}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
