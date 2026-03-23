//
//  ReminderDetailView.swift
//  Reminders
//
//  Created by Ryan Ferguson on 3/9/26.
//

import SwiftUI

struct ReminderDetailView: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var selectedColor: Color
    @Binding var selectedDate: Date
    
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                Text(description)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                    .padding(.top)
                VStack(alignment: .leading, spacing: 4) {
                    Text("  Title & Description")
                        .foregroundStyle(selectedColor)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("Title")
                            TextField("Title", text: $title)
                        }
                        .padding()
                        
                        Divider()
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Description")
                            TextField("Description", text: $description)
                        }
                        .padding()
                    }
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                }
                
                // MARK: Date Section
                VStack(alignment: .leading, spacing: 4) {
                    Text("  Date")
                        .foregroundStyle(selectedColor)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Date")
                        Spacer()
                        DatePicker(
                            "",
                            selection: $selectedDate,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                    }
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $isEditing) {
            EditSheet(title: $title, selectedColor: $selectedColor)
        }
        .navigationTitle($title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isEditing = true
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .foregroundStyle(selectedColor)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var title = "Sample Reminder"
    @Previewable @State var description = "Sample description"
    @Previewable @State var selectedColor = Color.blue
    @Previewable @State var selectedDate = Date()
    
    NavigationStack {
        ReminderDetailView(
                    title: $title,
                    description: $description,
                    selectedColor: $selectedColor,
                    selectedDate: $selectedDate
                )
    }
}
