//
//  ListTileNativeAdFactory.swift
//  Runner
//
//  Created by iMac on 06/09/21.
//

import Foundation
import UIKit
import google_mobile_ads

// TODO: Implement ListTileNativeAdFactory
class NativeAdView : FLTNativeAdFactory {

    var heightConstraint: NSLayoutConstraint?
    
    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("NativeAdView", owner: nil, options: nil)!.first
        let nativeAdView = nibView as? GADNativeAdView
        
        (nativeAdView?.headlineView as? UILabel)?.text = nativeAd.headline

        (nativeAdView?.bodyView as? UILabel)?.text = nativeAd.body
        nativeAdView?.bodyView?.isHidden = nativeAd.body == nil

        (nativeAdView?.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        nativeAdView?.callToActionView?.isHidden = nativeAd.callToAction == nil

        (nativeAdView?.iconView as? UIImageView)?.image = nativeAd.icon?.image
        nativeAdView?.iconView?.isHidden = nativeAd.icon == nil

        (nativeAdView?.starRatingView as? UIImageView)?.image = imageOfStars(from: nativeAd.starRating)
        nativeAdView?.starRatingView?.isHidden = nativeAd.starRating == nil

        (nativeAdView?.storeView as? UILabel)?.text = nativeAd.store
        nativeAdView?.storeView?.isHidden = nativeAd.store == nil

        (nativeAdView?.priceView as? UILabel)?.text = nativeAd.price
        nativeAdView?.priceView?.isHidden = nativeAd.price == nil

        (nativeAdView?.advertiserView as? UILabel)?.text = nativeAd.advertiser
        nativeAdView?.advertiserView?.isHidden = nativeAd.advertiser == nil

        nativeAdView?.callToActionView?.isUserInteractionEnabled = false
        nativeAdView?.nativeAd = nativeAd
        
        return nativeAdView
        
    }
    
    func imageOfStars(from starRating: NSDecimalNumber?) -> UIImage? {
      guard let rating = starRating?.doubleValue else {
        return nil
      }
      if rating >= 5 {
        return UIImage(named: "stars_5")
      } else if rating >= 4.5 {
        return UIImage(named: "stars_4_5")
      } else if rating >= 4 {
        return UIImage(named: "stars_4")
      } else if rating >= 3.5 {
        return UIImage(named: "stars_3_5")
      } else {
        return nil
      }
    }
}
