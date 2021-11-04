Class {
	#name : #IniWriter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'INI-Parser'
}

{ #category : #'instance creation' }
IniWriter class >> on: writeStream [

	"comment stating purpose of class-side method"

	^ self new
		  on: writeStream;
		  yourself
]

{ #category : #'instance creation' }
IniWriter class >> toString: aDictionary [

	^ String streamContents: [ :stream |
		(self on: stream) nextPut: aDictionary 
	]
	
]

{ #category : #accessing }
IniWriter >> nextPut: aDictionary [

	"Write the contents of the dictionary to the stream"

	aDictionary associationsDo: [ :keyAndValue | 
		keyAndValue value isDictionary
			ifTrue: [ 
				keyAndValue key isEmpty
					ifFalse: [ 
						stream
							nextPutAll: '[';
							nextPutAll: keyAndValue key asString;
							nextPutAll: ']';
							crlf ] .
						self nextPut: keyAndValue value.
				stream crlf ]
			ifFalse: [ 
				stream
					nextPutAll: keyAndValue key;
					nextPutAll: ' = ';
					nextPutAll: keyAndValue value;
					crlf ] ]
]

{ #category : #'instance creation' }
IniWriter >> on: writeStream [

	stream := writeStream 
]
