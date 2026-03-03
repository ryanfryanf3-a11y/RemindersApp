//
//  EditSheet.swift
//  Reminders
//
//  Created by Ryan Ferguson on 3/3/26.
//
import SwiftUI

struct EditSheet: View {
    // TODO: Add title binding
    @Binding var title: String
    @Binding var selectedColor: Color
    
    var body: some View {
        VStack(spacing: 20) {
                // TODO: Add list.bullet.circle.fill icon and TextField
            Text(title)
                .frame(maxWidth: .infinity, alignment: .center).font(.system(size: 35))
            VStack{
                Image(systemName: "list.bullet.circle.fill").font(.system(size: 80))
                    .padding()
                TextField("Task",text:$title).textFieldStyle(PlainTextFieldStyle())
                    .padding(8)
                    .background(Color(.systemGray6))
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    ).frame(width: 300,height: 20).font(.system(size: 20))
            }
            
            ColorChooser(selectedColor: $selectedColor)
            
            Spacer()
        }
        .foregroundStyle(selectedColor)
        .padding()
    }
}

#Preview {
    @Previewable @State var title: String = "Groceries"
    @Previewable @State var color: Color = .blue
    
    EditSheet(title: $title, selectedColor: $color).preferredColorScheme(.dark)
}
