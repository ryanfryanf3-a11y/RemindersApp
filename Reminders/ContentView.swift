//
//  ContentView.swift
//  Reminders
//
//  Created by Ryan Ferguson on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isEditing: Bool = false
    @State private var page: RemindersPage = RemindersPage(title: "Reminders",items: [Reminder(title: "Homework",description: "I hate coding",date:Date())],color: .black)
    
    var body: some View {
        VStack {
            HeaderView(page: $page, isEditing: $isEditing)
                .padding()
                .background(page.color.opacity(0.1))
            NavigationStack {
                List {
                    ForEach(page.items.indices, id: \.self) { index in
                        NavigationLink {
                            ReminderDetailView(
                                title: $page.items[index].title,
                                description: $page.items[index].description,
                                selectedColor: $page.color,
                                selectedDate: $page.items[index].date
                            )
                        } label: {
                            HStack {
                                Image(systemName: page.items[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(page.items[index].isCompleted ? .green : .gray)
                                    .onTapGesture {
                                        page.items[index].isCompleted.toggle()
                                    }
                                TextField("Task", text: $page.items[index].title)
                                    .strikethrough(page.items[index].isCompleted, pattern: .solid, color: .gray)
                                Text(page.items[index].date, style: .relative)
                            }
                            .foregroundStyle(page.color)
                        }
                    }
                    .onDelete { indexSet in
                        page.items.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(.plain)
            }
            
            Button {
                let newRem = Reminder(title: "Task",description: "To-do",date: Date())
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
