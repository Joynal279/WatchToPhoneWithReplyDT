//
//  ContentView.swift
//  WatchToPhoneWithReplyDT
//
//  Created by Joynal Abedin on 24/7/23.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = PhoneVM()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(vm.bookmarks.first?.title ?? "Hello Joy")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
