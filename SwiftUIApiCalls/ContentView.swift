//
//  ContentView.swift
//  SwiftUIApiCalls
//
//  Created by Doniyorbek Ibrokhimov  on 18/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.courses, id: \.self) { course in
                    CourseView(course: course)
                    
                }
            }
            .navigationTitle("Courses")
            .onAppear {
                Task {
                    await viewModel.getCourseData()
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}

struct CourseView: View {
    
    let course: Course
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: course.image), content: { returnedImage in
                returnedImage
                    .resizable()
                    .scaledToFit()
            }, placeholder: {
                ProgressView()
            })
            .frame(width: 130, height: 70)
            
            Text(course.name)
                .bold()
        }
        .padding(3)
    }
}
