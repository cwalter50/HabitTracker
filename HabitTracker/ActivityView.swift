//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Christopher Walter on 5/4/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    
    @State var title: String = ""
    @State var description: String = ""
    
    var activity: Activity
    
    
    init(activity: Activity)
    {
        self.activity = activity
//        self.title = activity.title
//        self.description = activity.description
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                TextField("Activity Title", text: $title)
                    .foregroundColor(Color.blue)
                    .font(.largeTitle)
                    .padding()
                    .onAppear(perform: setTitleAndDescription)
                TextField("Activity Description", text: $description)
                    .foregroundColor(.secondary)
                    .font(.body)
                    .padding()
                    .onAppear(perform: setTitleAndDescription)
                Text("Total Time: \(activity.timeString)")
                Button("Add Event") {
                    print("Add an event. Figure out how to add events to the habit and keep track of how long you are doing an Activity. Display the events in a list.")
                }
                Spacer()

                
            }
            // figure out how to list all the events
//                List {
//                    ForEach(activity.events) { event in
//                        Text(event.description)
//                    }
//                }
            }
        
        
        
    }
    
//    private func addEvent(){
//        let newEvent = Activity.Event(date: Date(), timeSpent: 10, description: "Worked on this hobby")
//        activity.events.append(newEvent)
//    }
    
    private func setTitleAndDescription() {
        title = activity.title
        description = activity.description
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let test: Activity = Activity(title: "Hobby", description: "a great hobby that provides lots of fun", events: [Activity.Event]())
        
        return ActivityView(activity: test)
    }
}
