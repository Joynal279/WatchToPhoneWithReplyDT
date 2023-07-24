//
//  PhoneVM.swift
//  WatchToPhoneWithReplyDT
//
//  Created by Joynal Abedin on 24/7/23.
//

import Foundation
import UIKit
import SwiftUI
import WatchConnectivity

class PhoneVM: NSObject, ObservableObject {
    
    private let session: WCSession
    
   @Published var bookmarks: [Bookmark] = []
   var bookMark: [Bookmark] = [Bookmark(title: "Hasan", date: "january", pageURL: "http://www.google.com")]
    
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
    
}

extension PhoneVM: WCSessionDelegate {
    
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//           guard let data: Data = message["data"] as? Data else { return }
//           let bookmark = Bookmark.decodeIt(data)
//           DispatchQueue.main.async {
//               self.bookmarks.append(bookmark)
//           }
//       }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        guard let data: Data = message["data"] as? Data else { return }
        let bookmark = Bookmark.decodeIt(data)
//        let dict: [String : Any] = ["data": bookMark.encodeIt()]
        DispatchQueue.main.async {
            self.bookmarks.append(bookmark)
            replyHandler(message)
        }
    }
       
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error {
            print("session activation failed with error: \(error.localizedDescription)")
        }
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        session.activate()
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    #endif
}

