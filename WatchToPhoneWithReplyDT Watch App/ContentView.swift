//
//  ContentView.swift
//  WatchToPhoneWithReplyDT Watch App
//
//  Created by Joynal Abedin on 24/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = WatchVM()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(vm.getDataFromPhone.first?.title ?? "Data not found")
                .onTapGesture {
                    vm.sentDataWatchToPhone()
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
