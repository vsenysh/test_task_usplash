
import UIKit

class WelcomeViewController: UITableViewController, NetworkManagerDelegate{
    
    
    
    private var networkManager = NetworkManager()
    private var infoForCells = [Result]()
    private var imageViewCell = ImageViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        networkManager.delegate = self
        networkManager.fetchNews()
        self.tableView.rowHeight = 350;
        self.tableView.estimatedRowHeight = 350;
        
        
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return infoForCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageViewCell else{
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell.delegate = self
        cell.downloadProgress.layer.cornerRadius = 10
        cell.downloadProgress.clipsToBounds = true
        
        
        
        let cellIndex = infoForCells[indexPath.row]
        
        
        cell.titleForImage.text = cellIndex.alt_description
        
        
        if let image = cellIndex.urls.thumb {
            cell.imageURL = image
        }
        
        
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func didUpdateNews(root: Root) {
        infoForCells = root.results
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// -Mark
extension WelcomeViewController: ImageCellDelegate{
    
    func downloadImages(imageURL: URL?) {
        guard let url = imageURL else {return}
        
            do{
                let imageData = try Data (contentsOf: url)
                let compressedImage = UIImage(data: imageData)
                UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
                
    
                let alert = UIAlertController(title: "Saved", message: "Your wonderful image has been saved", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
                
            }
            catch{
                print(error)
            }
        
        
    }
    
    
}
