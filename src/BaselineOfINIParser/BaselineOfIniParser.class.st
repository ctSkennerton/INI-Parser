Class {
	#name : #BaselineOfIniParser,
	#superclass : #BaselineOf,
	#category : #BaselineOfINIParser
}

{ #category : #baselines }
BaselineOfIniParser >> baseline: spec [ 
	<baseline>
	spec for: #common do: [ 
		spec package: 'INI-Parser';
		package: 'INI-Parser-Tests' with: [ spec requires: #('INI-Parser') ]
		 ]

]
