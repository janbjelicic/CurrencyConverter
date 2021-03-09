# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

def shared_pods
  pod 'RxSwift'
end

target 'CurrencyConverter' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CurrencyConverter
  shared_pods
  pod 'RxCocoa'
  pod 'R.swift'
  pod 'SwiftLint'
  
  target 'CurrencyConverterTests' do
    inherit! :search_paths
    shared_pods
  end

end
