//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 19/10/22.
//

import UIKit

class ChatToolBar: UIView {
    // MARK: - IBOutlets
    @IBOutlet var customView: UIView!

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
    func setup() {
        customView = loadViewFromNib()
        customView.frame = bounds
        customView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]

        addSubview(customView)
    }

    private func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }
}
