Class {
	#name : #IniWriterTest,
	#superclass : #TestCase,
	#category : #'INI-Parser-Tests'
}

{ #category : #tests }
IniWriterTest >> testWrite [

	| d s expected |
	d := Dictionary new
		     at: 'default' put: (Dictionary new
				      at: 'key' put: 'value';
				      yourself);
		     at: '' put: (Dictionary new
			      at: 'global' put: 'global value';
			      yourself);
		     yourself.

	s := IniWriter toString: d.

	expected := String streamContents: [ :stream | 
		            stream
			            nextPutAll: 'global = global value';
			            crlf;
			            crlf;
			            nextPutAll: '[default]';
			            crlf;
			            nextPutAll: 'key = value';
			            crlf;
			            crlf ].
	self assert: s equals: expected
]

{ #category : #tests }
IniWriterTest >> testWriteMultipleSections [

	| d s expected |
	d := Dictionary new
		     at: 'default' put: (Dictionary new
				      at: 'key' put: 'value';
				      yourself);
		     at: 'subsection' put: (Dictionary new
			      at: 'overwrite' put: true;
			      yourself);
		     yourself.

	s := IniWriter toString: d.

	expected := String streamContents: [ :stream | 
		            stream
			            nextPutAll: '[subsection]';
			            crlf;
			            nextPutAll: 'overwrite = true';
			            crlf;
			            crlf;
			            nextPutAll: '[default]';
			            crlf;
			            nextPutAll: 'key = value';
			            crlf;
			            crlf ].
	self assert: s equals: expected
]
