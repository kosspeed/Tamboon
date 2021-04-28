//
//  CharityTableViewCell.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//

import UIKit
import Kingfisher

class CharityTableViewCell: UITableViewCell {
    //MARK: IBOutlet
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    //MARK: Properties
    var didTapped: Delegated<Void> = Delegated<Void>()
    
    required init?(coder: NSCoder) {
        didTapped = Delegated<Void>()
        
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    @IBAction private func didTapped(_ sender: Any) {
        didTapped.callback?(())
    }
}

//MARK: Setup
extension CharityTableViewCell {
    func setup() {
        containerView
            .layer
            .cornerRadius(radius: 8)
            .shadow(color: .black,
                    opacity: 0.3,
                    offset: .zero,
                    radius: 10)
    }
}

//MARK: Configure
extension CharityTableViewCell {
    func configure(charity: CharityList.Charity) {
        titleLabel.text = charity.name
        thumbnailImageView.kf.setImage(with: charity.logoUrl,
                                       placeholder: charity.placeholderImage)
    }
}
