//
//  BackButton.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 08/11/2021.
//

import UIKit

class BackButton: UIButton {
    
    var viewController : UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    internal func setup() {
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06)
        backgroundColor = .white
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        addTarget(self, action: #selector(back), for: .touchUpInside)
        createShadow(color: shadowColor, opacity: 1, offset: CGSize(width: 0 , height: 0), radius: 5, cornerRadius: frame.height / 2)
        setImage(UIImage(named: CONSTANTS.BACK_ARROW), for: .normal)
    }
    
    
    @objc func back(){
        if let navigationController = viewController?.navigationController{
            navigationController.popViewController(animated: true)
        }else{
            viewController?.dismiss(animated: true)
        }
    }

    
}
