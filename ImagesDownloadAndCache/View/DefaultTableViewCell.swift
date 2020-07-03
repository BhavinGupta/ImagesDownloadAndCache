//
//  DefaultTableViewCell.swift
//  ImagesDownloadAndCache
//
//  Created by Bhavin Gupta on 03/07/20.
//  Copyright © 2020 Bhavin Gupta. All rights reserved.
//

import UIKit
import SDWebImage

class DefaultTableViewCell: UITableViewCell {
  var rows : Rows? {
    didSet {
      lblTitle.text = rows?.title
      lblDescriptions.text = rows?.descriptions
      imageURLLink.sd_setImage(with: URL(string: rows!.imageHref), placeholderImage: UIImage(named: "placeholder.png"))
    }
  }
  
  private let lblTitle : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont(name: "Helvetica-SemiBold", size: 18)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  private let lblDescriptions : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont(name: "Helvetica-Light", size: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  private let imageURLLink : UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit
    imgView.clipsToBounds = true
    return imgView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let stackViewImg = UIStackView(arrangedSubviews: [imageURLLink])
    stackViewImg.translatesAutoresizingMaskIntoConstraints = false
    stackViewImg.distribution = .fillProportionally
    addSubview(stackViewImg)
    
    let stackView = UIStackView(arrangedSubviews: [lblTitle,lblDescriptions])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fillProportionally
    stackView.axis = .vertical
    stackView.spacing = 5
    addSubview(stackView)
    
    let mainStackView = UIStackView(arrangedSubviews: [stackViewImg,stackView])
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    mainStackView.distribution = .fillEqually
    mainStackView.axis = .horizontal
    mainStackView.spacing = 5
    addSubview(mainStackView)
    
    mainStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), size: CGSize(width: 0, height: 0))
    
    self.layoutIfNeeded()
  }
  
  //MARK:- Awake from Nib
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  //MARK:- Required Init Method
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK:- Set Selected Method
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
