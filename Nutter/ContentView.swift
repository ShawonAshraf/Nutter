//
//  ContentView.swift
//  Nutter
//
//  Created by Shawon Ashraf on 23.04.20.
//  Copyright © 2020 Shawon Ashraf. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //MARK: coredata
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: NutItem.getAllNuts()) var nutItems: FetchedResults<NutItem>
    
    // MARK: state
    @State private var clearAlert = false
    
    var body: some View {
        VStack {
            
            //MARK: header
            HStack {
                Text("Nut Count : \(self.nutItems.count)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                // MARK: add a new nut
                Button(action: {
                    print("You nutted eh?")
                    
                    
                    let nut = NutItem(context: self.context)
                    nut.createdAt = Date()
                    
                    // save
                    do {
                        try self.context.save()
                    } catch {
                        print("Error Saving your precious nut")
                    }
                }) {
                    Text("💦")
                        .font(.largeTitle)
                }
            }
            .padding()
            
            //MARK: space
            Spacer()
            
            //MARK: nut info rows
            List {
                Section(header: Text("Stay Home and Nut")) {
                    ForEach(self.nutItems) { nutItem in
                        Text("\(nutItem.createdAt!)")
                    }
                }
            }
            
            // MARK: bottom panel for clear button
            HStack {
                Spacer()
                // MARK: clear all nuts
                Button(action: {
                    print("Clearing all nuts")
                    
                    // delete one by one
                    for nut in self.nutItems {
                       self.context.delete(nut)
                    }
                    
                    // update state
                    self.clearAlert.toggle()
                }) {
                    Text("😇 Clean me!")
                }.alert(isPresented: $clearAlert) {
                    // show a confirmation alert
                    Alert(title: Text("You've cleared your sins"),
                          message: Text("These sudden delights have violent consequences"),
                        dismissButton: .default(Text("I can live with that!")))
                }
                Spacer()
            }
            .padding()
            .background(Color(.darkGray))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
