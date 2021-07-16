//
//  VCDetail.swift
//  PhunwareICC
//
//  Created by Rex Karnufex on 5/6/21.
//

import UIKit

class VCDetail: UIViewController {
    
    @IBOutlet weak var dTImage: UIImageView!
    @IBOutlet weak var dTShare: UIButton!
    @IBOutlet weak var dTDate: UILabel!
    @IBOutlet weak var dTTitle: UILabel!
    @IBOutlet weak var dTSubtitle: UILabel!
    @IBOutlet weak var dTDescription: UITextView!
    
    var getName = String()
    var getSubtitle = String()
    var getDescription = String()
    var getDate = String()
    var getImage = UIImage()
    
    private var gradient: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dTImage.image = getImage
        dTTitle.text = getName
        dTSubtitle.text = getSubtitle
        dTDescription.text = getDescription
        dTDate.text = getDate
        
        self.dTImage.contentMode = UIView.ContentMode.scaleToFill
        
        dTImage.backgroundColor = .white
        // let initialColor = UIColor.red
        let initialColor = UIColor.init(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        let finalColor = initialColor.withAlphaComponent(0.0)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.colors = [finalColor.cgColor, initialColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = dTImage.bounds
        dTImage.layer.addSublayer(gradientLayer)
    }
    
    @IBAction func TapShare(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["www.apple.com"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}
