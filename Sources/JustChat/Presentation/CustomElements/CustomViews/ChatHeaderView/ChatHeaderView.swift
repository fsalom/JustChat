//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 15/12/22.
//

import UIKit

class ChatHeaderView: UIView {
    // MARK: - IBOutlets
    @IBOutlet public weak var customView: UIView!
    @IBOutlet public weak var contentView: UIView!
    @IBOutlet public weak var dateLabel: UILabel!

    // MARK: - Properties

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Functions
    private func setup() {
        customView = loadViewFromNib()
        customView.frame = bounds

        customView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                       UIView.AutoresizingMask.flexibleHeight]

        addSubview(customView)
        contentView.layer.cornerRadius = 10
    }

    private func loadViewFromNib() -> UIView! {
        let bundle = Bundle.module
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }

    func display(from timestamp: Int) {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy"
        dateLabel.text = dateFormatter.string(from: date)
    }
}
