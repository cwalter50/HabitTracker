//
//  ContentView.swift
//  HabitTracker
//
//  Created by Christopher Walter on 5/2/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentation // this was added to fix a bug in the navigation bar. After addActivity sheet was dismissed, the navigation bar became inactive and I couldn't click on the plus button.
    
    @ObservedObject var activities = Activities()
    
    @State private var shouldAddNewActivity = false // this is used to display activity Sheet
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink(destination: ActivityView(activity: activity)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(activity.title)
                                    .font(.title)
                                Text(activity.description)
                                    
                                    .foregroundColor(Color.secondary)
                            }
                            Spacer()
                            Text("Time Spent: \(activity.timeString)")
                        }
                    }
                    
                }
            }
            .navigationBarTitle(Text("Habit Tracker"))
            .navigationBarItems(trailing: Button(action: {
                self.shouldAddNewActivity = true
            }) {
                Image(systemName: "plus")
            })
                

                .sheet(isPresented: $shouldAddNewActivity, onDismiss: {
                    self.shouldAddNewActivity = false
                }) {
                AddActivityView(activities: self.activities)

            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
