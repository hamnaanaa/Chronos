//
//  DailyTasksList.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import SwiftUI

struct TextDivider: View {
    let label: String
    let horizontalPadding: CGFloat
    let color: Color
    
    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }
    
    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }
    
    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

struct DailyTasksList: View {
    @ObservedObject var tasksContainer: MockedTasks
    
    let day: String
    
    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Text(day)
                        .font(.title.bold())
                    Spacer()
                }
                .padding(.bottom, 10)
                
                Divider()
                
                ForEach(MockedCategories.allCategories) { category in
                    DailyTasksSection(title: category.title, color: category.color)
                }
                .padding([.leading, .trailing], 20)
                
                Spacer()
            }
        }
    }
    
    struct DailyTasksSection: View {
        @State private var isExpanded = false
        
        let title: String
        let color: Color
        
        // Fix it
        //        @State private var sectionTasks: [String] = []
        
        var body: some View {
            DisclosureGroup(isExpanded: $isExpanded) {
                VStack {
                    // fix it
                    //                    ForEach(sectionTasks, id: \.self) { sectionTask in
                    //                        DailyTasksEntry(text: $sectionTasks, parentColor: color)
                    //                    }
                    AddTaskButton(color: color)
                    AddTaskButton(color: color)
                    AddTaskButton(color: color)
                    AddTaskButton(color: color)
                    AddTaskButton(color: color)
                    AddTaskButton(color: color)
                }
            } label: {
                Text(title).foregroundColor(color)
            }
        }
        
        struct AddTaskButton: View {
            let color: Color
            
            var body: some View {
                Button {
                    // TODO: implement
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Text("New Task")
                        Spacer()
                        Spacer()
                    }
                    .foregroundColor(color)
                }
            }
        }
        
        struct DailyTasksEntry: View {
            // TODO: add more complex checkmark logic here with more squares
            @State private var isDone = false
            
            @Binding private var text: String
            
            let parentColor: Color
            
            var body: some View {
                HStack {
                    Button {
                        isDone.toggle()
                    } label: {
                        Image(systemName: isDone ? "checkmark.square" : "square")
                    }
                    TextField("", text: $text)
                    Spacer()
                }
                .foregroundColor(parentColor)
            }
        }
}

struct DailyTasksList_Previews: PreviewProvider {
    static var previews: some View {
        DailyTasksList(tasksContainer: MockedTasks(), day: "Tuesday")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
