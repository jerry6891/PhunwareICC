//
//  ViewController.swift
//  PhunwareICC
//
//  Created by Rex Karnufex on 5/4/21.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var swBattles: UITableView!
    
    // MARK: GET DATA (JSON)
    let getDataUrl: String = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
    
    var model = [Model]()
    
    // MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VCTableViewCell
        
        let user: Model
        user = model[indexPath.row]
        cell.titleLabel.text = user.title
        cell.subTitleLabel.text = user.locationline2
        cell.descriptionLabel.text = user.description
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy HH:mm 'at' a"

        if let date = dateFormatterGet.date(from: user.date!) {
            cell.dateLabel.text = dateFormatterPrint.string(from: date).replacingOccurrences(of: "PM", with: "pm")
        } else {
           print("Date Error")
        }
        
        if user.image != nil {
            Alamofire.request(user.image!).responseImage { response in
                if let image = response.result.value {
                    cell.mainImageView.image = image
                    cell.mainImageView.layer.cornerRadius = 20
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user: Model
        user = model[indexPath.row]
        
        let vCDetail = storyboard?.instantiateViewController(identifier: "VCDetail") as? VCDetail
        vCDetail?.getName = user.title!
        vCDetail?.getSubtitle = user.locationline2!
        vCDetail?.getDescription = user.description!
        vCDetail?.getDate = user.date!
        
        let url = NSURL(string: user.image!)
            let imagedata = NSData.init(contentsOf: url! as URL)
        if imagedata != nil {
            vCDetail?.getImage = UIImage(data:imagedata! as Data)!
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy HH:mm 'at' a"
        if let date = dateFormatterGet.date(from: user.date!) {
            vCDetail?.getDate = dateFormatterPrint.string(from: date).replacingOccurrences(of: "PM", with: "pm")
        } else {
           print("Date Error")
        }
        
        self.navigationController?.pushViewController(vCDetail!, animated: true)
    }
    
    // MARK: Alamofire Request
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(getDataUrl).responseJSON { response in
            if let json = response.result.value {
                let usersArray: NSArray = json as! NSArray
                for i in 0..<usersArray.count {
                    self.model.append(Model(
                        title: (usersArray[i] as AnyObject).value(forKey: "title") as? String,
                        description: (usersArray[i] as AnyObject).value(forKey: "description") as? String,
                        locationline2: (usersArray[i] as AnyObject).value(forKey: "locationline2") as? String,
                        image: (usersArray[i] as AnyObject).value(forKey: "image") as? String,
                        date: (usersArray[i] as AnyObject).value(forKey: "date") as? String
                    ))
                }
                self.swBattles.reloadData()
            }
        }
    }
}

// MARK: Shadow & Border Styling
extension UIView {
    
    @IBInspectable var maskToBounds: Bool {
        get { return layer.masksToBounds }
        set { layer.masksToBounds = false }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    @IBInspectable var shadowOpacity: CGFloat {
        get { return CGFloat(layer.shadowOpacity) }
        set { layer.shadowOpacity = Float(newValue) }
    }

    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    @IBInspectable var shadowColor: UIColor? {
        get { guard let cgColor = layer.shadowColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidthV: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderColorV: UIColor? {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue?.cgColor }
    }
}
