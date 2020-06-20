//
//  PS_MultipleExpandableTblVC.swift
//  PS_MultipleExpandableTblVC
//
//  Created by Prince Sojitra on 29/04/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import UIKit

class PS_MultipleExpandableTblVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let kHeaderSectionTag: Int = 1000;
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    
    //For Expand Set - 1, For Collapse Set - 0
    var expandedSections: Array<Any> = [1,0,0,0,0,0,0,0,0]
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackButton()
        
        //dummy data
        sectionNames = [ "iPhone", "iPad", "Apple Watch" ,"iPhone", "iPad", "Apple Watch","iPhone", "iPad", "Apple Watch" ];
        sectionItems = [ ["iPhone SE is designed with the following features to reduce its environmental impact", "iPhone 5s", "iPhone 6", "iPhone 6 Plus", "iPhone 7", "iPhone 7 Plus"],
                         ["iPad Mini", "iPad Air 2", "Letting go of your old device is easy with Apple Trade In. If it’s in good shape, you can trade it in for Apple Store credit. If it’s not eligible for credit, we’ll recycle it responsibly at no cost to you. Good for you. Good for the planet.", "iPad Pro 9.7"],
                         ["Apple Watch", "Final assembly supplier sites do not generate any waste sent to landfill", "Apple Watch 2 (Nike)"], ["iPhone SE is designed with the following features to reduce its environmental impact", "iPhone 5s", "iPhone 6", "iPhone 6 Plus", "iPhone 7", "iPhone 7 Plus"],
                         ["iPad Mini", "iPad Air 2", "Letting go of your old device is easy with Apple Trade In. If it’s in good shape, you can trade it in for Apple Store credit. If it’s not eligible for credit, we’ll recycle it responsibly at no cost to you. Good for you. Good for the planet.", "iPad Pro 9.7"],
                         ["Apple Watch", "Final assembly supplier sites do not generate any waste sent to landfill", "Apple Watch 2 (Nike)"],["iPhone SE is designed with the following features to reduce its environmental impact", "iPhone 5s", "iPhone 6", "iPhone 6 Plus", "iPhone 7", "iPhone 7 Plus"],
                         ["iPad Mini", "iPad Air 2", "Letting go of your old device is easy with Apple Trade In. If it’s in good shape, you can trade it in for Apple Store credit. If it’s not eligible for credit, we’ll recycle it responsibly at no cost to you. Good for you. Good for the planet.", "iPad Pro 9.7"],
                         ["Apple Watch", "Final assembly supplier sites do not generate any waste sent to landfill", "Apple Watch 2 (Nike)"]
        ];
        
        let nib = UINib(nibName: "CustomSectionHeader", bundle: nil)
        self.tableView.register(nib, forHeaderFooterViewReuseIdentifier: "customSectionHeader")
        self.tableView!.tableFooterView = UIView()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "BackArrowWhite"), for: .normal) // Image can be downloaded from here below link
        backButton.setTitle("", for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Tableview DataSource & Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionNames.count > 0 {
            tableView.backgroundView = nil
            return sectionNames.count
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "HelveticaNeue", size: 20.0)!
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel;
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isSectionExpanded  = self.expandedSections[section] as! Int
        if (isSectionExpanded == 1) {
            let sectionItems = self.sectionItems[section] as! NSArray
            return sectionItems.count;
        } else {
            return 0;
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "customSectionHeader") as! CustomSectionHeader
        header.lbltitle.text = self.sectionNames[section] as? String
        header.imageVwExpand.tag = kHeaderSectionTag + section
        
        let isSectionExpanded  = self.expandedSections[section] as! Int
        if (isSectionExpanded == 1) {
            header.imageVwExpand.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
        }
        
        //make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(self.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
        
        return header
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblCell_ExpandItem", for: indexPath) as! TblCell_ExpandItem
        let section = self.sectionItems[indexPath.section] as! NSArray
        cell.lblName.textColor = UIColor.black
        cell.lblName.text = section[indexPath.row] as? String
        
        if indexPath.row == section.count - 1{
            cell.vwSeperator.isHidden = true
        }
        else{
            cell.vwSeperator.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
// MARK: - Expand / Collapse Methods
extension PS_MultipleExpandableTblVC {
    
    
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        let imageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
        let isSectionExpanded = self.expandedSections[section] as! Int
        
        if isSectionExpanded == 1 {
            //collapse
            self.expandedSections[section] = 0
            let cImageView = self.view.viewWithTag(kHeaderSectionTag + section) as? UIImageView
            tableViewCollapeSection(section, imageView: cImageView!)
        }
        else{
            //expand
            self.expandedSections[section] = 1
            self.tableViewExpandSection(section, imageView: imageView!)
        }
        
    }
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.sectionItems[section] as! NSArray
        
        if (sectionData.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.tableView!.beginUpdates()
            self.tableView!.deleteRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.sectionItems[section] as! NSArray
        
        if (sectionData.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
}

