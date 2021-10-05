Class {
	#name : #BaselineOfINIParser,
	#superclass : #BaselineOf,
	#category : #BaselineOfINIParser
}

{ #category : #baselines }
BaselineOfINIParser >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: 'INI-Parser';
			group: 'Deployment' with: 'INI-Parser';
			package: 'INI-Parser-Tests' with: [ spec requires: 'INI-Parser' ];
			group: 'Tests' with: 'INI-Parser-Tests';
			group: 'Development' with: 'Tests';
			group: 'CI' with: 'Tests';
			group: 'default' with: 'Development' ]
]

{ #category : #baselines }
BaselineOfINIParser >> projectClass [

	^ MetacelloCypressBaselineProject
]
