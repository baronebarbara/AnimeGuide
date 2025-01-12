import UIKit

extension UIImageView {
    func loadImage(from url: URL?, placeholder: UIImage?) {
        self.image = placeholder

        guard let url = url else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                return
            }

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
