# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'SWVLMovies' do
  use_frameworks!

  # Pods for SWVLMovies
  inhibit_all_warnings!
  
  pod 'Alamofire', '~> 5.0.0-beta.5'
  pod 'ObjectMapper', '~> 3.4'
  pod 'Kingfisher', '~> 5.0'
  pod 'SwiftLint' , '~> 0.30.1'

  target 'SWVLMoviesTests' do
    inherit! :search_paths

  end

  target 'SWVLMoviesUITests' do
    inherit! :search_paths

  end

end

plugin 'cocoapods-keys', {
    :project => "SWVLMovies",
    :keys => [
        "flickrAPIKeyDevelopment"
    ]
}