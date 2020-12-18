import Foundation

protocol NetworkManagerDelegate{
    func didUpdateNews(root: Root)
}
struct NetworkManager{
    
     var delegate: NetworkManagerDelegate?
    

    
    func fetchNews() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/search/photos"
        urlComponents.queryItems = [.init(name: "client_id", value: "cn-xTwbvpcPUcpOgwJ2WIehB8UB641vs6GasCGMurzI"),
                                    .init(name:"query", value: "London"),
                                    .init(name:"per_page", value: "20")]

        
        if let url = urlComponents.url {
            performRequest(url)

        }
    }

    func performRequest(_ url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                return

            }

            if let safedata = data {
                if let root = parseJson(data: safedata){
                    delegate?.didUpdateNews(root: root)
                }
            }

        }.resume()


        func parseJson(data: Data) -> Root?{
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let root = try decoder.decode(Root.self, from: data)

                
                return root

            }catch{
                print(error)
                return nil
            }

        }
    }

}
