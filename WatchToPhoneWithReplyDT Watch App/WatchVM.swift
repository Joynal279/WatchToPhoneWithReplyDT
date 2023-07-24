//
//  WatchVM.swift
//  WatchToPhoneWithReplyDT Watch App
//
//  Created by Joynal Abedin on 24/7/23.
//

import Foundation
import UIKit
import SwiftUI
import WatchConnectivity

class WatchVM: NSObject, ObservableObject {
    
    @Published var getDataFromPhone: [Bookmark] = []
    
    var bookmarks: [Bookmark] = [Bookmark(title: "Joynal", date: "january", pageURL: "http://www.google.com")]
    
    private let session: WCSession
    
    init(session: WCSession = .default){
           self.session = session
           super.init()
           session.delegate = self
           session.activate()
        
        #if os(iOS)
        print("Connection provider initialized on phone")
        #endif

        #if os(watchOS)
        print("Connection provider initialized on watch")
        #endif
        
        self.connect()
        
   }
    
    func connect(){
        guard WCSession.isSupported() else {
            print("WCSession not supported")
            return
        }
        
        session.activate()
    }
    
    func sentDataWatchToPhone(){
        bookmarks.forEach { bookmark in
            let dict: [String : Any] = ["data": bookmark.encodeIt()]
            session.sendMessage(dict, replyHandler: nil)
            session.sendMessage(dict) { replyData in
                
                guard let data: Data = replyData["data"] as? Data else { return }
                let bookmark = Bookmark.decodeIt(data)
                self.getDataFromPhone.append(bookmark)
                
            } errorHandler: { error in
                print(error.localizedDescription)
            }

        }
    }
    
}

extension WatchVM: WCSessionDelegate {
    
     
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error {
            print("session activation failed with error: \(error.localizedDescription)")
        }
    }

}


