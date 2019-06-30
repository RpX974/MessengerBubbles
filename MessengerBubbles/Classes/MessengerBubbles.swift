//
//  MessengerBubbles.swift
//  MessengerBubbles
//
//  Created by Laurent Grondin on 28/06/2019.
//

import UIKit
import Kingfisher

// MARK: - MessengerBubbles

@IBDesignable
open class MessengerBubbles: UIView {
    
    // MARK: - Constants

    public struct PrivateConstants {
        public static let onlineBubbleColor: UIColor = .init(red: 90/255, green: 212/255, blue: 57/255, alpha: 1)
    }
    
    // MARK: - Views
    private var onlineBubbleContainer: UIView!
    private var onlineBubble: UIView!

    // MARK: - Properties

    @IBInspectable
    public var isOnline: Bool = false {
        didSet { showOnlineBubble(self.isOnline) }
    }
    
    @IBInspectable
    public var onlineBubbleColor: UIColor = PrivateConstants.onlineBubbleColor {
        didSet {
            guard let onlineBubble = self.onlineBubble else { return }
            onlineBubble.backgroundColor = self.onlineBubbleColor
        }
    }
    
    @IBInspectable
    private var borderColor: UIColor = .white

    @IBInspectable
    private var enableOnlineBubble: Bool = true

    private var borderWidth: CGFloat!
    private var size: CGFloat!
    
    // MARK: - Initializers
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setupUI(with: self.frame.width, borderColor: borderColor)
        setupOnlineBubble(size: size, borderColor: borderColor, borderWidth: borderWidth, onlineBubbleColor: onlineBubbleColor, enableOnlineBubble: enableOnlineBubble, isOnline: isOnline)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(size: CGFloat,
                borderColor: UIColor = .white,
                onlineBubbleColor: UIColor = PrivateConstants.onlineBubbleColor,
                enableOnlineBubble: Bool = true,
                isOnline: Bool = false) {
        super.init(frame: .zero)
        setupUI(with: size, borderColor: borderColor)
        setupOnlineBubble(size: size, borderColor: borderColor, borderWidth: borderWidth, onlineBubbleColor: onlineBubbleColor, enableOnlineBubble: enableOnlineBubble, isOnline: isOnline)
    }
    
    public init(images: [UIImage?]?,
                size: CGFloat,
                borderColor: UIColor = .white,
                onlineBubbleColor: UIColor = PrivateConstants.onlineBubbleColor,
                enableOnlineBubble: Bool = true,
                isOnline: Bool = false) {
                super.init(frame: .zero)
        
        setupUI(with: size, borderColor: borderColor)
        createBubbles(with: images, size: size, borderWidth: borderWidth, borderColor: borderColor)
        setupOnlineBubble(size: size, borderColor: borderColor, borderWidth: borderWidth, onlineBubbleColor: onlineBubbleColor, enableOnlineBubble: enableOnlineBubble, isOnline: isOnline)
    }
    
    public init(urls: [String?]?,
                size: CGFloat,
                borderColor: UIColor = .white,
                onlineBubbleColor: UIColor = PrivateConstants.onlineBubbleColor,
                enableOnlineBubble: Bool = true,
                isOnline: Bool = false) {
        super.init(frame: .zero)
        
        setupUI(with: size, borderColor: borderColor)
        createBubbles(with: urls, size: size, borderWidth: borderWidth, borderColor: borderColor)
        setupOnlineBubble(size: size, borderColor: borderColor, borderWidth: borderWidth, onlineBubbleColor: onlineBubbleColor, enableOnlineBubble: enableOnlineBubble, isOnline: isOnline)
    }
    
    // MARK: - Private Functions

    private func setupUI(with size: CGFloat,
                         borderColor: UIColor) {
        self.backgroundColor = .clear
        self.withSize(.init(width: size, height: size))
            .withCornerRadius(size / 2)
            .layer.masksToBounds = false
        self.size = size
        self.borderWidth = size / 20
        self.borderColor = borderColor
    }
    
    private func createBubbles(with images: [UIImage?]?,
                               size: CGFloat,
                               borderWidth: CGFloat,
                               borderColor: UIColor) {
        guard let images = images else { return }
        switch images.count {
        case let count where count == 1:
            createImageView(image: images[0], bubbleWidth: size, borderWidth: 0)
        case let count where count > 1:
            createBubble(image: images[0], size: size,
                         borderColor: borderColor, borderWidth: borderWidth,
                         isFirst: true)
            createBubble(image: images[1], size: size,
                         borderColor: borderColor, borderWidth: borderWidth,
                         isFirst: false)
        default: break
        }
    }
    
    private func createBubbles(with urls: [String?]?,
                               size: CGFloat,
                               borderWidth: CGFloat,
                               borderColor: UIColor) {
        guard let urls = urls else { return }
        switch urls.count {
        case let count where count == 1:
            createImageView(urlString: urls[0], bubbleWidth: size, borderWidth: 0)
        case let count where count > 1:
            createBubble(urlString: urls[0], size: size,
                         borderColor: borderColor, borderWidth: borderWidth,
                         isFirst: true)
            createBubble(urlString: urls[1], size: size,
                         borderColor: borderColor, borderWidth: borderWidth,
                         isFirst: false)
        default: break
        }
    }
    
    private func createBubble(image: UIImage? = nil,
                              urlString: String? = nil,
                              size: CGFloat,
                              borderColor: UIColor,
                              borderWidth: CGFloat,
                              isFirst: Bool) {
        
        let bubbleWidth = size / 1.5
        let bubbleSize = CGSize(width: bubbleWidth, height: bubbleWidth)
        let bubbleCornerRadius = bubbleWidth / 2
        
        UIView()
            .withCornerRadius(bubbleCornerRadius)
            .withBorder(width: borderWidth, color: borderColor)
            .addTo(self)
            .sendIn(.front)
            .anchor(top: isFirst ? self.topAnchor : nil,
                     leading: isFirst ? nil : self.leadingAnchor,
                     bottom: isFirst ? nil : self.bottomAnchor,
                     trailing: isFirst ? self.trailingAnchor : nil,
                     size: bubbleSize)
            .createImageView(image: image,
                             urlString: urlString,
                             bubbleWidth: bubbleWidth,
                             borderWidth: borderWidth)
    }
    
    private func setupOnlineBubble(size: CGFloat,
                                   borderColor: UIColor,
                                   borderWidth: CGFloat,
                                   onlineBubbleColor: UIColor,
                                   enableOnlineBubble: Bool,
                                   isOnline: Bool) {
        guard enableOnlineBubble else { return }
        createOnlineBubble(color: onlineBubbleColor, size: size, borderWidth: borderWidth, borderColor: borderColor)
        self.onlineBubbleColor = onlineBubbleColor
        self.isOnline = isOnline
    }
    
    private func createOnlineBubble(color: UIColor,
                                    size: CGFloat,
                                    borderWidth: CGFloat,
                                    borderColor: UIColor) {
        let onlineBubbleSize = size / 3.5
        let onlineBubbleCornerRadius = onlineBubbleSize / 2
        let onlineBubbleBorderWidth = onlineBubbleSize / 3.5
        
        self.onlineBubbleContainer = UIView(backgroundColor: borderColor)
            .withSize(.init(width: onlineBubbleSize, height: onlineBubbleSize))
            .withCornerRadius(onlineBubbleCornerRadius)
            .addTo(self)
            .anchor(top: nil, leading: nil,
                     bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        
        let greenBubbleSize = onlineBubbleSize - onlineBubbleBorderWidth
        let greenBubbleCornerRadius = greenBubbleSize / 2
        
        self.onlineBubble = UIView(backgroundColor: color)
            .withSize(.init(width: greenBubbleSize,
                            height: greenBubbleSize))
            .withCornerRadius(greenBubbleCornerRadius)
            .addTo(onlineBubbleContainer)
            .sendIn(.front)
            .centerInSuperview()
    }
    
    // MARK: - Public Functions
    
    public func setImages(with images: [UIImage?]?) {
        createBubbles(with: images, size: size, borderWidth: borderWidth, borderColor: borderColor)
    }
    
    public func setImages(with urls: [String?]?) {
        createBubbles(with: urls, size: size, borderWidth: borderWidth, borderColor: borderColor)
    }
    
    // MARK: - Animations
    
    private func showOnlineBubble(_ bool: Bool) {
        guard let _ = onlineBubbleContainer else { return }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.transformOnlineBubble(bool)
            }, completion: nil)
        }
    }
    
    private func transformOnlineBubble(_ bool: Bool) {
        self.onlineBubbleContainer.layer.removeAllAnimations()
        self.onlineBubbleContainer.transform = bool ? .identity : .init(scaleX: 0.001, y: 0.001)
    }
}

// MARK: - Extensions
// MARK: - CreateImageView

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init(image: image)
        self.contentMode = contentMode
        self.clipsToBounds = true
    }
}

extension UIView {
    
    @discardableResult
    fileprivate func createImageView(image: UIImage? = nil,
                                     urlString: String? = nil,
                                     bubbleWidth: CGFloat,
                                     borderWidth: CGFloat) -> UIImageView {
        let imageViewCornerRadius = (bubbleWidth - borderWidth * 2) / 2
        let imageView: UIImageView = UIImageView(image: image, contentMode: .scaleAspectFill)
            .withCornerRadius(imageViewCornerRadius)
            .addTo(self)
            .fillSuperview(padding: .init(top: borderWidth,
                                           left: borderWidth,
                                           bottom: borderWidth,
                                           right: borderWidth))
            .sendIn(.back)
        guard let urlString = urlString, let url = URL(string: urlString) else { return imageView }
        imageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil)
        return imageView
    }
}

// MARK: - UIView+Layout

typealias Constraint = NSLayoutConstraint

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> Self {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return self
    }
    
    @discardableResult
    func fillSuperview(padding: UIEdgeInsets = .zero) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return self
        }
        
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
    
    @discardableResult
    func centerInSuperview(size: CGSize = .zero) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        return self
    }
    
    @discardableResult
    func centerXToSuperview() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        return self
    }
    
    @discardableResult
    func centerYToSuperview() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        return self
    }
    
    @discardableResult
    func withSize(_ size: CGSize) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    func withBorder(width: CGFloat, color: UIColor) -> Self {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    func withCornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        clipsToBounds = true
        return self
    }
    
    @discardableResult
    func addTo(_ view: UIView) -> Self {
        view.addSubview(self)
        return self
    }

    enum Position { case back, front }
    
    @discardableResult
    func sendIn(_ position: Position) -> Self {
        guard let superview = self.superview else { return self }
        switch position {
            case .back: superview.sendSubviewToBack(self)
            case .front: superview.bringSubviewToFront(self)
        }
        return self
    }

    convenience init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
}

