Pod::Spec.new do |s|
	s.name = 'JSQMessagesViewController'
	s.version = '7.3.5'
	s.summary = 'An elegant messages UI library for iOS.'
	s.homepage = 'http://jessesquires.github.io/JSQMessagesViewController'
	s.license = 'MIT'
	s.platform = :ios, '9.0'

	s.author = 'Jesse Squires'
	s.social_media_url = 'https://twitter.com/jesse_squires'

	s.screenshots = ['https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot0.png',
                    'https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot1.png',
                    'https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot2.png',
                    'https://raw.githubusercontent.com/jessesquires/JSQMessagesViewController/develop/Screenshots/screenshot3.png']

	s.source = { :git => 'https://github.com/jessesquires/JSQMessagesViewController.git', :tag => s.version }
	
	
	# The bizarre dance of subspecs below is to avoid including two collection view cell xibs that are crashing
	#  ibtool most of the time in the Xcode 11 beta (bug report FB7028654).
	# Zingle's usage of JSQMessagesViewController uses custom collection view cells and can exclude these files.
	# Cocoapods also has a bug with `exclude_files` that prevents that more elegant solution in a single subspec.
	# This means that `ss.resources` needs to be explicitly enumerated as well, which is not great.
	
	s.default_subspec = 'include-cell-xibs'
	
	s.subspec 'core-resources' do |ss|
		ss.source_files = 'JSQMessagesViewController/**/*.{h,m}'
		ss.resources = ['JSQMessagesViewController/Assets/JSQMessagesAssets.bundle']
	end
	
	s.subspec 'xibs-without-cells' do |ss|
		ss.dependency 'JSQMessagesViewController/core-resources'
		ss.resources = ['JSQMessagesViewController/Controllers/JSQMessagesViewController.xib', 'JSQMessagesViewController/Views/JSQMessagesLoadEarlierHeaderView.xib', 'JSQMessagesViewController/Views/JSQMessagesTypingIndicatorFooterView.xib', 'JSQMessagesViewController/Views/JSQMessagesToolbarContentView.xib']
	end

	s.subspec 'include-cell-xibs' do |ss|
		ss.dependency 'JSQMessagesViewController/xibs-without-cells'
		ss.resources = ['JSQMessagesViewController/Views/JSQMessagesCollectionViewCellOutgoing.xib',  'JSQMessagesViewController/Views/JSQMessagesCollectionViewCellIncoming.xib']
	end

	s.frameworks = 'QuartzCore', 'CoreGraphics', 'CoreLocation', 'MapKit', 'AVFoundation'
	s.requires_arc = true

	s.dependency 'JSQSystemSoundPlayer', '~> 2.0.1'
	
	s.deprecated = true
end
