//
//  TasksTableHeader.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 30.03.22.
//

import SwiftUI

struct TasksTableHeader: View {
    @Binding var sortingPredicate: (Binding<Task>, Binding<Task>) -> Bool
    
    @State private var activeSorting: ActiveSorting = .dateCreatedAsc
    
    // TODO: add custom button coloring depending on active filtering
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Divider().background(Color.BackgroundColor.primary)
                HStack {
                    // category
                    categoryHeader(alignment: geo)
                    
                    // status
                    statusHeader(alignment: geo)
                    
                    // title
                    titleHeader(alignment: geo)
                    
                    // epics
                    epicsHeader(alignment: geo)
                    
                    // dateDue
                    dateDueHeader(alignment: geo)
                    
                    // dateCreated
                    dateCreatedHeader(alignment: geo)
                }
                Divider().background(Color.BackgroundColor.primary)
            }
        }
    }
    
    // TODO: REFACTOR: consider creating an App-wide container for all icon names and generic stuff in one place
    
    /// Category header wrapper
    private func categoryHeader(alignment geo: GeometryProxy) -> some View {
        Button {
            onButtonPressed(for: \Task.category)
        } label: {
            Group {
                // TODO: arrow direction depending on state
                Divider().background(Color.BackgroundColor.primary)
                label(title: "Category", for: \Task.category)
                    .frame(
                        width: geo.size.width * TasksTableConstraints.categoryWidth,
                        alignment: .leading
                    )
            }
        }
    }
    
    /// Status header wrapper
    private func statusHeader(alignment geo: GeometryProxy) -> some View {
        Button {
            onButtonPressed(for: \Task.status)
        } label: {
            Group {
                Divider().background(Color.BackgroundColor.primary)
                label(title: "Status", for: \Task.status)
                    .frame(
                        width: geo.size.width * TasksTableConstraints.statusWidth,
                        alignment: .leading
                    )
            }
        }
    }
    
    /// Title header wrapper
    private func titleHeader(alignment geo: GeometryProxy) -> some View {
        Button {
            onButtonPressed(for: \Task.title)
        } label: {
            Group {
                Divider().background(Color.BackgroundColor.primary)
                label(title: "Task", for: \Task.title)
                    .frame(
                        width: geo.size.width * TasksTableConstraints.titleWidth,
                        alignment: .topLeading
                    )
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
    /// Epics header wrapper
    private func epicsHeader(alignment geo: GeometryProxy) -> some View {
        Group {
            Divider().background(Color.BackgroundColor.primary)
            // this label is not generic as no sorting of epics lists is currently supported
            Text("Epics")
                .font(.headline)
                .foregroundColor(.TextColor.gray)
                .frame(
                    width: geo.size.width * TasksTableConstraints.epicsWidth,
                    alignment: .leading
                )
        }
    }
    
    /// DateDue header wrapper
    private func dateDueHeader(alignment geo: GeometryProxy) -> some View {
        Button {
            onButtonPressed(for: \Task.dateDue)
        } label: {
            Group {
                Divider().background(Color.BackgroundColor.primary)
                label(title: "Due", for: \Task.dateDue)
                    .frame(
                        width: geo.size.width * TasksTableConstraints.dateDueWidth
                    )
            }
        }
    }
    
    /// DateCreated header wrapper
    private func dateCreatedHeader(alignment geo: GeometryProxy) -> some View {
        Button {
            onButtonPressed(for: \Task.dateCreated)
        } label: {
            Group {
                Divider().background(Color.BackgroundColor.primary)
                label(title: "Created", for: \Task.dateCreated)
                    .frame(
                        width: geo.size.width * TasksTableConstraints.dateCreatedWidth
                    )
                Divider().background(Color.BackgroundColor.primary)
            }
        }
    }
    
    private func label<T: Comparable>(title: String, for keyPath: KeyPath<Task, T>) -> some View {
        Label(title, systemImage: "arrowtriangle.\(activeSorting.isActiveAndAsc(for: keyPath) ? "down" : "up").circle.fill")
            .labelStyle(HeadlineLabelStyle())
            .foregroundColor(activeSorting.isActive(for: keyPath) ? .TextColor.blue : .TextColor.gray)
    }
    
    /// A helper function wrapping all generic functionality associated with a header button press
    private func onButtonPressed<T:Comparable>(for keyPath: KeyPath<Task, T>) {
        if activeSorting.isActiveAndAsc(for: keyPath) {
            sortingPredicate = { $0.wrappedValue[keyPath: keyPath] > $1.wrappedValue[keyPath: keyPath] }
            activeSorting.invertOrder()
            
        } else {
            sortingPredicate = { $0.wrappedValue[keyPath: keyPath] < $1.wrappedValue[keyPath: keyPath] }
            activeSorting.setForKeyPath(keyPath)
        }
    }
    
    /// A helper state machine used to track which filtering is currently active
    private enum ActiveSorting {
        /// filterings for different `Task` properties and two orderings (ascending/descending)
        case categoryAsc, categoryDesc,
             statusAsc, statusDesc,
             titleAsc, titleDesc,
             epicsAsc, epicsDesc,
             dateDueAsc, dateDueDesc,
             dateCreatedAsc, dateCreatedDesc
        
        /// Detect if this sorting state is in ascending order and is active for the given keyPath property
        func isActiveAndAsc<T: Comparable>(for keyPath: KeyPath<Task, T>) -> Bool {
            switch self {
            case .categoryAsc:
                return keyPath == \Task.category
            case .statusAsc:
                return keyPath == \Task.status
            case .titleAsc:
                return keyPath == \Task.title
            case .epicsAsc:
                return keyPath == \Task.epics
            case .dateDueAsc:
                return keyPath == \Task.dateDue
            case .dateCreatedAsc:
                return keyPath == \Task.dateCreated
            default:
                return false
            }
        }
        
        /// Detect if this state  is active for the given keyPath property
        func isActive<T: Comparable>(for keyPath: KeyPath<Task, T>) -> Bool {
            switch self {
            case .categoryAsc, .categoryDesc:
                return keyPath == \Task.category
            case .statusAsc, .statusDesc:
                return keyPath == \Task.status
            case .titleAsc, .titleDesc:
                return keyPath == \Task.title
            case .epicsAsc, .epicsDesc:
                return keyPath == \Task.epics
            case .dateDueAsc, .dateDueDesc:
                return keyPath == \Task.dateDue
            case .dateCreatedAsc, .dateCreatedDesc:
                return keyPath == \Task.dateCreated
            }
        }
        
        /// Change current state to the one matching the given keyPath property
        mutating func setForKeyPath<T: Comparable>(_ keyPath: KeyPath<Task, T>) {
            switch keyPath {
            case \Task.category:
                self = .categoryAsc
            case \Task.status:
                self = .statusAsc
            case \Task.title:
                self = .titleAsc
            case \Task.epics:
                self = .epicsAsc
            case \Task.dateDue:
                self = .dateDueAsc
            case \Task.dateCreated:
                self = .dateCreatedAsc
            default:
                fatalError("Unknown keyPath type '\(String(describing: keyPath))' in \(self) detected")
            }
        }
        
        /// Flip the sort ordering of the current state
        mutating func invertOrder() {
            switch self {
            case .categoryAsc:
                self = .categoryDesc
            case .categoryDesc:
                self = .categoryAsc
            case .statusAsc:
                self = .statusDesc
            case .statusDesc:
                self = .statusAsc
            case .titleAsc:
                self = .titleDesc
            case .titleDesc:
                self = .titleAsc
            case .epicsAsc:
                self = .epicsDesc
            case .epicsDesc:
                self = .epicsAsc
            case .dateDueAsc:
                self = .dateDueDesc
            case .dateDueDesc:
                self = .dateDueAsc
            case .dateCreatedAsc:
                self = .dateCreatedDesc
            case .dateCreatedDesc:
                self = .dateCreatedAsc
            }
        }
    }
}

struct TasksTableHeader_Previews: PreviewProvider {
    static var previews: some View {
        TasksTableHeader(sortingPredicate: .constant({ _,_ in return true }))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
