//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Christopher Walter on 5/3/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct AddActivityView: View {
    
    @ObservedObject var activities: Activities
    
    @State var title: String = ""
    @State var description: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
        .navigationBarTitle("Add new activity")
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    let events: [Activity.Event] = [Activity.Event]()
                    let theActivity = Activity(title: self.title, description: self.description, events: events)
                self.activities.items.append(theActivity)
                    self.activities.saveToUserDefaults()
                    
                // didSdet is not working.... Have to save to user defaults manuall
                
                self.presentationMode.wrappedValue.dismiss()
                
                
            })
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
