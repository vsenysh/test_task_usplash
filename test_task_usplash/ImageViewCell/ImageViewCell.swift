//
//  TableViewCell.swift
//  test_task_usplash
//
//  Created by Vasyl Senyshyn on 17.12.2020.
//

import UIKit
protocol ImageCellDelegate: class{
    func downloadImages(imageURL: URL?)
}

class ImageViewCell: UITableViewCell {

     weak var delegate: ImageCellDelegate?
    
    
    var imageURL:URL?{
        didSet{
            guard let url = imageURL else {return}
            imageForCell.load(url: url)
        }
    }

    override class func awakeFromNib() {
        super.awakeFromNib()
      
    }
    @IBOutlet weak var titleForImage: UILabel!
    
    @IBOutlet weak var imageForCell: UIImageView!
    
    @IBOutlet weak var downloadProgress: UIProgressView!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var downloadPressedLabel: UIButton!
    
    @IBAction func downloadPressed(_ sender: UIButton) {
        percentLabel.text = "100%"
        downloadProgress.progress = 1.0
        delegate?.downloadImages(imageURL: imageURL)
        
        
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
