//
//  ContentView.swift
//  Reminders
//
//  Created by Ryan Ferguson on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isEditing: Bool = false
    // TODO: Add an @State property to hold a RemindersPage struct
    @State private var page: RemindersPage = RemindersPage(title: "Reminders",items: [Reminder(title: "Homework")],color: .black)
    
    var body: some View {
        VStack {
            HeaderView(page: $page, isEditing: $isEditing)
                                .padding()
                                .background(page.color.opacity(0.1))
            
            List {
                // TODO: Loop through the page's reminders using ForEach
                ForEach($page.items) { $reminder in
                    HStack {
                        Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(reminder.isCompleted ? .green : .gray)
                            .onTapGesture {
                                reminder.isCompleted.toggle()
                            }
                        TextField("Task",text:$reminder.title).strikethrough(reminder.isCompleted, pattern: .solid, color: .gray)
                        }.foregroundStyle(page.color)
                }
                .onDelete { indexSet in
                    page.items.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            
            Button {
                let newRem = Reminder(title: "Task")
                page.items.append(newRem)
            } label: {
                Label("New Reminder", systemImage: "plus.circle.fill")
                    .font(.headline)
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
                                .padding()
                                .background(Color(.systemBackground))

        }
        .sheet(isPresented: $isEditing) {
            EditSheet(title: $page.title,selectedColor: $page.color)
        }
    }
}
struct HeaderView: View {
    @Binding var page: RemindersPage
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            Text(page.title)
                .font(.largeTitle.bold())
                .foregroundStyle(page.color)
            
            Spacer()
            
            Button {
                isEditing = true
            } label: {
                Image(systemName: "pencil.circle")
                    .font(.title2)
            }
        }
    }
}

#Preview {
    ContentView()
}
