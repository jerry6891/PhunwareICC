//
//  VCTableViewCell.swift
//  PhunwareICC
//
//  Created by Rex Karnufex on 5/4/21.
//

import UIKit

class VCTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainImageView.frame = CGRect(x: 10, y: 0, width: 40, height: 40)
        self.mainImageView.contentMode = UIView.ContentMode.scaleToFill
        self.mainImageView.cornerRadiusV = 10
        self.mainImageView.shadowRadius = 5
        self.mainImageView.shadowOpacity = 0.2
        self.mainImageView.shadowColor = UIColor.black
        self.mainImageView.shadowOffset = CGSize(width: 4, height: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
