//
//  ListTableViewCell.swift
//  ListView
//
//  Created by NigilDharsan on 13/10/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func loadCellData(details: ResponseData) {
        self.nameLbl.text! = "Title :  \(details.title!) "
        self.nameLbl.numberOfLines = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
