//
//  ButtonComponents.swift
//
//  Created by Eric Ziegler
//

import UIKit
import AudioToolbox

// MARK: - AppStyle Buttons

class AppStyleButton : UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }

    func commonInit() {
        if type(of: self) === AppStyleButton.self {
            fatalError("AppStyleButton not meant to be used directly. Use its subclasses.")
        }
    }

}

class LightButton: AppStyleButton {
    override func commonInit() {
        if let font = self.titleLabel?.font {
            self.titleLabel?.font = UIFont.appLightFontOfSize(font.pointSize)
        }
    }
}

class RegularButton: AppStyleButton {
    override func commonInit() {
        if let font = self.titleLabel?.font {
            self.titleLabel?.font = UIFont.appFontOfSize(font.pointSize)
        }
    }
}

class MediumButton: AppStyleButton {
    override func commonInit() {
        if let font = self.titleLabel?.font {
            self.titleLabel?.font = UIFont.appMediumFontOfSize(font.pointSize)
        }
    }
}

class BoldButton: AppStyleButton {
    override func commonInit() {
        if let font = self.titleLabel?.font {
            self.titleLabel?.font = UIFont.appBoldFontOfSize(font.pointSize)
        }
    }
}

// MARK: - ActionButton

class ActionButton: MediumButton {

    private var spinner: UIActivityIndicatorView!

    override func commonInit() {
        super.commonInit()
        self.layer.cornerRadius = 6
        self.setTitleColor(UIColor.black, for: .normal)
        self.setTitleColor(UIColor.black, for: .disabled)
        self.titleLabel?.font = UIFont.appBoldFontOfSize(22)
        setupSpinner()
        updateStyle()
    }

    private func setupSpinner() {
        spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = self.titleColor(for: .normal)
        spinner.isHidden = true
        spinner.hidesWhenStopped = true
        self.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: spinner as Any, attribute: .centerY, relatedBy: .equal, toItem: self.titleLabel, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: spinner as Any, attribute: .trailing, relatedBy: .equal, toItem: self.titleLabel, attribute: .leading, multiplier: 1, constant: -10))
    }

    @IBInspectable override var isEnabled: Bool {
        didSet {
            updateStyle()
        }
    }

    func updateStyle() {
        if isEnabled == true {
            self.alpha = 1
        } else {
            self.alpha = 0.6
        }
    }

    func showSpinner(text: String? = nil) {
        if let text = text {
            self.setTitle(text, for: .normal)
        }
        spinner.startAnimating()
        spinner.isHidden = false
    }

    func hideSpinner(text: String? = nil) {
        if let text = text {
            self.setTitle(text, for: .normal)
        }
        spinner.stopAnimating()
    }

}

// MARK: - CircleButton

class CircleButton: RegularButton {
    override func commonInit() {
        super.commonInit()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.size.height / 2
    }
}

// MARK: - LikeButton

class PopButton: RegularButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        AudioServicesPlaySystemSound(1519)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: nil)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.transform = .identity
        }, completion: nil)
    }

}

// MARK: - RemoteButton

enum RemoteImageCacheType {
    case none
    case memory
    case disk
}

private let imageMemoryCache = NSCache<NSString, UIImage>()
private let imageDiskCacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

class RemoteButton: RegularButton {

    override func commonInit() {
        super.commonInit()
        self.clipsToBounds = true
        self.imageView?.clipsToBounds = true
        self.backgroundColor = UIColor.secondarySystemBackground
        self.imageView?.contentMode = .scaleAspectFill
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
    }

    var imageURL: String = ""

    func load(url: String?, altImage: UIImage? = nil, isCircle: Bool = true, cornerRadius: CGFloat = 0, allowsInteraction: Bool = false, backgroundColor: UIColor = UIColor.clear, opaqueBackground: Bool = false, contentMode: UIImageView.ContentMode = .scaleAspectFill, cacheType: RemoteImageCacheType = .memory) {
        // reset background color
        self.backgroundColor = backgroundColor

        // clip the image into a circle, if necessary
        self.layoutIfNeeded()
        if isCircle == true {
            self.layer.cornerRadius = self.bounds.size.height / 2
            self.imageView?.contentMode = .scaleAspectFill
        } else {
            self.layer.cornerRadius = cornerRadius
            self.imageView?.contentMode = contentMode
        }

        // determine whether the user can tap the image
        self.isUserInteractionEnabled = allowsInteraction

        // attempt to load the image if there is one
        if let url = url, url.count > 0 {
            // we have a url, load the image
            imageURL = url
            if let cachedImage = loadImageFromCache(imageURL: imageURL, cacheType: cacheType) {
                // load from cache
                if opaqueBackground == false {
                    self.backgroundColor = UIColor.clear
                }
                self.setImage(cachedImage, for: .normal)
            } else {
                // load remotely
                DispatchQueue.global().async { [weak self] in
                    if let imageURL = URL(string: url), let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            if self?.imageURL == url {
                                if opaqueBackground == false {
                                    self?.backgroundColor = UIColor.clear
                                }
                                self?.setImage(image, for: .normal)
                                self?.saveImageToCache(imageURL: url, image: image, cacheType: cacheType)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.setImage(altImage, for: .normal)
                        }
                    }
                }
            }
        } else {
            self.setImage(altImage, for: .normal)
        }
    }

    private func cleanURLForCaching(url: String) -> String {
        return url.replacingOccurrences(of: "/", with: "").replacingOccurrences(of: ":", with: "")
    }

    private func loadImageFromCache(imageURL: String, cacheType: RemoteImageCacheType) -> UIImage? {
        let url = cleanURLForCaching(url: imageURL)
        switch cacheType {
        case .memory:
            return imageMemoryCache.object(forKey: url as NSString)
        case .disk:
            let fileURL = imageDiskCacheDirectory.appendingPathComponent(url)
            if let imageData = try? Data(contentsOf: fileURL) {
                return UIImage(data: imageData)
            } else {
                return nil
            }
        default:
            return nil
        }
    }

    private func saveImageToCache(imageURL: String, image: UIImage, cacheType: RemoteImageCacheType) {
        let url = cleanURLForCaching(url: imageURL)
        switch cacheType {
        case .memory:
            imageMemoryCache.setObject(image, forKey: url as NSString)
        case .disk:
            let fileURL = imageDiskCacheDirectory.appendingPathComponent(url)
            if let imageData = image.pngData() {
                try? FileManager.default.removeItem(at: fileURL)
                try? imageData.write(to: fileURL, options: .atomic)
            }
        default:
            break
        }
    }
    
    func displayInitials(initials: String?, bgColor: UIColor = UIColor.darkGray, textColor: UIColor = UIColor.white) {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 2
        self.backgroundColor = bgColor
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(initials, for: .normal)
        self.titleLabel?.textAlignment = .center
    }

}
