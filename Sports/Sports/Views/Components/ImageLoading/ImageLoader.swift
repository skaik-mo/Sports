//
//  ImageLoader.swift
//  Sports
//
//  Created by Mohammed Skaik on 07/10/2024.
//


import UIKit

@Observable
class ImageLoader {
    let url: String?
    var image: UIImage? = nil
    var errorMessage: String? = nil
    var isLoading: Bool = false

    init(url: String?) {
        self.url = url
    }

    func fetch() {
        guard image == nil && !isLoading else { return }
        guard let url = url, let fetchURL = URL(string: url) else {
            errorMessage = "Sorry, something went wrong."
            return
        }
        isLoading = true
        errorMessage = nil
        let request = URLRequest(url: fetchURL, cachePolicy: .returnCacheDataElseLoad)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    self?.errorMessage = "Sorry, the connection to our server failed."
                } else if let data = data, let image = UIImage(data: data) {
                    self?.image = image
                } else {
                    self?.errorMessage = "Sorry, something went wrong."
                }
            }
        }
        task.resume()
    }

}