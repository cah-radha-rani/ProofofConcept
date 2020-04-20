import Foundation
//JSON Model
struct Root: Decodable {
    let rows: [InlineData]
}
struct InlineData: Decodable {
    let image: String
    let title: String
    let description: String}

struct Networking {
    
    private init() {}
    static let shared = Networking()
    
    // MARK - Fetch JSON Data
    func fetchJSON(url: URL, completion: @escaping (Result<[Root], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let jsonData = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 || httpResponse.statusCode == 200, error == nil else {
                
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    
                    completion(.failure(.domainError))
                    completion(.failure(.responseError))
                }
                return
            }
            
            //MARK: Get Data Back
            do {
                let json = try JSONDecoder().decode([Root].self, from: data! )
                //try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
                HomeController.shared.incomingDataArray = json
                DispatchQueue.main.async {
                    HomeController.shared.tableView.reloadData()
                }
            } catch {
                completion(.failure(.decodingError))
            }
            } .resume()
    }
}







