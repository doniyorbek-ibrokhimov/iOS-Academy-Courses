//
//  ViewModel.swift
//  SwiftUIApiCalls
//
//  Created by Doniyorbek Ibrokhimov  on 18/06/23.
//

import SwiftUI

struct Course: Hashable, Codable {
    let name: String
    let image: String
}

class ViewModel: ObservableObject {
    
    @Published var courses: [Course] = []
    
    func getCourseData() async {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else { return }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("error")
            }
            
            let decoder = JSONDecoder()
            let courses = try decoder.decode([Course].self, from: data)
            
            DispatchQueue.main.async {
                self.courses =  courses
            }
            
        } catch {
            fatalError("error \(error.localizedDescription)")
        }
    }
}
