//
//  ImageLoader.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/16/1400 AP.
//

import UIKit

class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    func loadImage(_ url: URL,pointSize: CGSize, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        // 1
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        // 2
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 3
            defer {self.runningRequests.removeValue(forKey: uuid) }
            
            // 4
            if let data = data, let image = self.optimizeSize(imageAt: data, to: pointSize) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            
            // 5
            guard let error = error else {
                // without an image or an error, we'll just ignore this for now
                // you could add your own special error cases for this scenario
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
            
            // the request was cancelled, no need to call the callback
        }
        task.resume()
        
        // 6
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
    
    func optimizeSize(imageAt imageData: Data,
                    to pointSize: CGSize,
                    scale: CGFloat = UIScreen.main.scale) -> UIImage? {

        // Create an CGImageSource that represent an image
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions) else {
            return nil
        }
        
        // Calculate the desired dimension
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        
        // Perform downsampling
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        
        // Return the downsampled image as UIImage
        return UIImage(cgImage: downsampledImage)
    }
}

class UIImageLoader {
  static let loader = UIImageLoader()

  private let imageLoader = ImageLoader()
  private var uuidMap = [UIImageView: UUID]()

  private init() {}

    func load(_ url: URL, for imageView: UIImageView) {
      // 1
        let token = imageLoader.loadImage(url, pointSize: imageView.frame.size) { result in
        // 2
        defer { self.uuidMap.removeValue(forKey: imageView) }
        do {
          // 3
          let image = try result.get()
          DispatchQueue.main.async {
            imageView.image = image
          }
        } catch {
          // handle the error
        }
      }

      // 4
      if let token = token {
        uuidMap[imageView] = token
      }
    }

    func cancel(for imageView: UIImageView) {
      if let uuid = uuidMap[imageView] {
        imageLoader.cancelLoad(uuid)
        uuidMap.removeValue(forKey: imageView)
      }
    }
    

}

extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
