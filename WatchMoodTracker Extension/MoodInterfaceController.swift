//
//  MoodInterfaceController.swift
//  WatchMoodTracker Extension
//
//  Created by Ruhsane Sawut on 12/6/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class MoodInterfaceController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    var entries: [MoodEntry] = []

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let goodEntry = MoodEntry(mood: .good, date: Date())
        let badEntry = MoodEntry(mood: .bad, date: Date())
        let neutralEntry = MoodEntry(mood: .neutral, date: Date())
        let amazingEntry = MoodEntry(mood: .amazing, date: Date())
        let terribleEntry = MoodEntry(mood: .terrible, date: Date())
        
        entries = [goodEntry, badEntry, neutralEntry, amazingEntry, terribleEntry]
        
        table.setNumberOfRows(entries.count, withRowType: "moodRow")
        
        for index in 0..<entries.count {
            guard let controller = table.rowController(at: index) as? MoodRow else { continue }
            controller.moodObj = entries[index]
        }
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let mood = entries[rowIndex]
        
        if WCSession.default.isReachable == true {
            // App is reachable
            WCSession.default.transferUserInfo(["mood":mood.mood.stringValue, "date": mood.date])
        }
        pop()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
