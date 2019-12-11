//
//  DialogViewController.swift
//  CustomDialogs
//
//  Created by Evgeniy Safronov on 15.08.17.
//  Copyright © 2017 Evgeniy Safronov. All rights reserved.
//

import UIKit

class DialogContainerViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentCenterYConstraint: NSLayoutConstraint!
    
    private var contentController: UIViewController?
    private var presentCompletion: (()->Void)?
    private var position: DialogPosition?
    
    fileprivate static func showDialog(_ contentController: UIViewController, from rootController: UIViewController, position: DialogPosition, completion: @escaping ()->Void) {
        let podBundle = Bundle(for: DialogContainerViewController.self)
        let resBundlePath = podBundle.path(forResource: "AnyControllerDialog", ofType: "bundle")!
        let resBundle = Bundle(path: resBundlePath)
        
        let dialogController = DialogContainerViewController(nibName: "DialogContainer", bundle: resBundle)
        dialogController.contentController = contentController
        dialogController.presentCompletion = completion
        dialogController.modalPresentationStyle = .overFullScreen
        dialogController.position = position
        rootController.present(dialogController, animated: false, completion: nil)
    }
    
    // MARK: - Initial configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureContentView()
        configureConstraints()
        placeContentController()
        hideContentInitially()
    }
    
    private func configureContentView() {
        contentView.layer.cornerRadius = 6
        contentView.clipsToBounds = true
    }
    
    private func configureConstraints() {
        disableConstraint(contentBottomConstraint)
        disableConstraint(contentCenterYConstraint)
        
        if let width = position?.width {
            contentWidthConstraint.constant = width
            disableConstraint(contentRightConstraint)
            disableConstraint(contentLeftConstraint)
        } else {
            disableConstraint(contentWidthConstraint)
            disableConstraint(contentCenterXConstraint)
        }
        
        if let height = position?.height {
            contentHeightConstraint.constant = height
        }
    }
    
    private func placeContentController() {
        guard let content = contentController else {
            return
        }
        
        addChild(content)
        contentView.addSubview(content.view)
        content.view.frame = contentView.bounds
        content.didMove(toParent: self)
    }
    
    private func hideContentInitially() {
        contentTopConstraint.constant = view.frame.height
        view.backgroundColor = UIColor.clear
    }
    
    // MARK: - Dialog show animation
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showContent()
    }
    
    private func showContent() {
        contentTopConstraint.constant = position?.top ?? 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.presentCompletion?()
        })
    }
    
    // MARK: - Dialog dismiss animation
    
    fileprivate func dismissDialog(completion: @escaping ()->Void) {
        contentTopConstraint.constant = view.frame.height
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.removeFromParent()
            self.dismiss(animated: false, completion: completion)
        })
    }
    
    private func removeContentController() {
        contentController?.willMove(toParent: nil)
        contentController?.view.removeFromSuperview()
        contentController?.removeFromParent()
    }
    
    // MARK: - Utils
    
    private func enableConstraint(_ constraint: NSLayoutConstraint) {
        if !constraint.isActive {
            constraint.isActive = true
        }
    }
    
    private func disableConstraint(_ constraint: NSLayoutConstraint) {
        if constraint.isActive {
            constraint.isActive = false
        }
    }
}

fileprivate struct DialogPosition {
    var height: CGFloat
    var width: CGFloat?
    var top: CGFloat
}

public extension UIViewController {
    func showDialog(_ contentController: UIViewController, height: CGFloat, width: CGFloat? = nil, top: CGFloat, completion: @escaping ()->Void) {
        let position = DialogPosition(height: height, width: width, top: top)
        DialogContainerViewController.showDialog(contentController, from: self, position: position, completion: completion)
    }
    
    func dismissDialog(_ contentController: UIViewController, completion: @escaping ()->Void) {
        guard let container = contentController.parent as? DialogContainerViewController else {
            print("Unable to dismiss table view controller because of wrong type of its parent controller")
            return
        }
        
        container.dismissDialog(completion: completion)
    }
}
