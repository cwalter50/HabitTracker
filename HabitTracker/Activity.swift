//
//  Activity.swift
//  HabitTracker
//
//  Created by Christopher Walter on 5/2/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation


struct Activity: Codable, Identifiable
{
    struct Event: Codable
    {
        var date: Date = Date()
        var timeSpent: Int = 0
        var description: String = ""
    }
    var title: String
    var description: String
    var id = UUID()
    var events: [Event]
    
    var totalTime: Int {
        var total = 0
        for event in events
        {
            total += event.timeSpent
        }
        return total
    }

    var timeString: String {
        // display as hours and minutes
        let hours = totalTime / 60
        let minutes = totalTime % 60

        let hoursString = String(format: "%02i", hours)
        let minString = String(format: "%02i", minutes)
        return "\(hoursString):\(minString)"
    }
    
}


// this will be a list of all of the activities
class Activities: ObservableObject
{
    @Published var items: [Activity] {
        didSet {
            print("didSet is called on Activities!!!")
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items") // everytime we add a new item, this will update the data in Userdefaults
                print("saving items to UserDefaults")
            }
            else {
                print("failed to save anything to user defaults")
            }
            
        }
    }
    
    init() { // this will check if there are items in UserDefaults, and decode them into [Activity]. If none exist, then it will make items an empty array
        print("init from activities")
        if let items = UserDefaults.standard.data(forKey: "Items")
        {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: items) {
                self.items = decoded
                print("loaded from userdefaults")
                return
            }
        }
        else {
            print("No record of items in user defaults")
        }
        // failed to load anything from user defaults
        self.items = []
    }
    
    // i had to this becuase didSet was not being triggered by .append()
    func saveToUserDefaults()
    {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items") // everytime we add a new item, this will update the data in Userdefaults
//            print("saving items to UserDefaults")
        }
//        else {
//            print("failed to save anything to user defaults")
//        }
    }
}


