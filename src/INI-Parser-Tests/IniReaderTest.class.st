Class {
	#name : #IniReaderTest,
	#superclass : #TestCase,
	#category : #'INI-Parser-Tests'
}

{ #category : #tests }
IniReaderTest >> testEmptyValueDontEatNextKeyValuePair [

	| reader parsed expected |
	expected := Dictionary new.
	expected at: '' put: Dictionary new.
	expected at: '' at: 'server' put: ''.
	expected at: '' at: 'port' put: '143'.

	reader := IniReader on: 'server=<l>port=143' expandMacros readStream.
	parsed := reader parse.

	self assert: parsed equals: expected
]

{ #category : #tests }
IniReaderTest >> testParse [
	| r v expected |	
		
	expected := Dictionary new.
	expected at: 'Section' put: Dictionary new.
	expected at: 'Section' at: 'key' put: 'value'.
		
	r := IniReader on: ('[Section]',Character lf asString ,'key=value') readStream .
	v := r parse .
	
	self assert: v equals: expected .
	
	r := IniReader on: ('[Section]',Character lf asString ,Character lf asString, 'key = value') readStream .
	v := r parse .

	self assert: v equals: expected .
	
	expected := Dictionary new.
	expected at: 'Section' put: Dictionary new.
	expected at: 'Section' at: 'key' put: 'value'.
	expected at: 'Section' at: 'key2' put: 'value2'.
		
	r := IniReader on: ('[Section]',Character lf asString , 'key = value', Character lf asString,'key2 = value2') readStream .
	v := r parse .

	self assert: v equals: expected .
	

]

{ #category : #tests }
IniReaderTest >> testParseEmptySection [

	| tmp1 tmp2 tmp3 tmp4 |
	tmp4 := Dictionary new.
	tmp4 at: 'Section' put: Dictionary new.
	tmp2 := IniReader on:
		        ('[Section]' , Character lf asString) readStream.
	tmp3 := tmp2 parse.
	self assert: tmp3 equals: tmp4
]

{ #category : #tests }
IniReaderTest >> testParseGlobalKeyValues [

	| reader parsed expected |

	expected := Dictionary new.
	expected at: '' put: Dictionary new.
	expected at: '' at: 'server' put: '192.0.2.62'.
	expected at: '' at: 'port' put: '143'.

	reader := IniReader on: 'server=192.0.2.62<l>port=143' expandMacros readStream.
	parsed := reader parse.

	self assert: parsed equals: expected
]

{ #category : #tests }
IniReaderTest >> testParseKeyValuePair [
	| r v |
	r := IniReader on: 'key=value' readStream.
	v := r parseKeyValuePair.
	self assert: v equals: {'key' . 'value'}.
	
	r := IniReader on: 'key=' readStream.
	v := r parseKeyValuePair.
	self assert: v equals: {'key' . ''}.

	r := IniReader on: 'key with spaces=value' readStream.
	v := r parseKeyValuePair.
	self assert: v equals: {'key with spaces' . 'value'}.
	r := IniReader on: 'key = value' readStream.
	v := r parseKeyValuePair.
	self assert: v equals: {'key' . 'value'}.
	r := IniReader on: 'key = value value two value' readStream.
	v := r parseKeyValuePair.
	self assert: v equals: {'key' . 'value value two value'}.
	r := IniReader on: 'key = value := value = value' readStream.
	v := r parseKeyValuePair.
	self assert: v equals: {'key' . 'value := value = value'}.
	r := IniReader on: 'key: value' readStream.
	r keyValueSeparator: $:.
	v := r parseKeyValuePair.
	self assert: v equals: {'key' . 'value'}
]

{ #category : #tests }
IniReaderTest >> testParseSection [
	| r v |	
		
	r := IniReader on: '[Section]' readStream .
	v := r parseSection .
	self assert: v equals: 'Section' .
	
	
]

{ #category : #tests }
IniReaderTest >> testParseTwoKeyValue [
	| r v expected |	
		
	
	expected := Dictionary new.
	expected at: 'Section' put: Dictionary new.
	expected at: 'Section' at: 'key' put: 'value'.
	expected at: 'Section' at: 'key2' put: 'value2'.
		
	r := IniReader on: ('[Section]',Character lf asString , 'key = value', Character lf asString,'key2 = value2') readStream .
	v := r parse .

	self assert: v equals: expected .
	
]

{ #category : #tests }
IniReaderTest >> testParseTwoSections [

	| r v expected |
	r := IniReader on: '[Section]

key = value

[Section2]

key2 = value2' readStream.
	v := r parse.

	expected := Dictionary new.
	expected at: 'Section' put: Dictionary new.
	expected at: 'Section' at: 'key' put: 'value'.
	expected at: 'Section2' put: Dictionary new.
	expected at: 'Section2' at: 'key2' put: 'value2'.

	self assert: v equals: expected
]

{ #category : #tests }
IniReaderTest >> testParseTwoSectionsWithCommentAfterSection [

	| r v expected |

	r := IniReader on:
		     '[database]<l>; use IP address in case network name resolution is not working<l>server=192.0.2.62<l>port=143'
			     expandMacros readStream.
	v := r parse.

	expected := Dictionary new.
	expected at: 'database' put: Dictionary new.
	expected at: 'database' at: 'server' put: '192.0.2.62'.
	expected at: 'database' at: 'port' put: '143'.

	self assert: v equals: expected
]

{ #category : #tests }
IniReaderTest >> testParseWithCommentedKeyValue [

	| r v expected |
	r := IniReader on: '[Section]
key = value
#key2 = value2' readStream.

	v := r parse.

	expected := Dictionary new.
	expected at: 'Section' put: Dictionary new.
	expected at: 'Section' at: 'key' put: 'value'.


	self assert: v equals: expected
]

{ #category : #tests }
IniReaderTest >> testParseWithCommentedSection [

	| r v expected |
	r := IniReader on:
		     ('[Section]' , Character lf asString , 'key = value'
		      , Character lf asString , '#[Section2]' , Character lf asString
		      , 'key2 = value2') readStream.
	v := r parse.

	expected := Dictionary new.
	expected at: 'Section' put: Dictionary new.
	expected at: 'Section' at: 'key' put: 'value'.
	expected at: 'Section' at: 'key2' put: 'value2'.

	self assert: v equals: expected
]

{ #category : #tests }
IniReaderTest >> testParseWithMultipleSectionsAndComments [

	| r v expected |
	r := IniReader on: '[Section]
key = value
#key2 = value2


[Section2]

key=value
anotherKey  = value

#[some commented out section]
#
#key = value
# another key=  some value

# this is a comment
[Section 3]

key = value


' readStream.

	v := r parse.

	expected := Dictionary new.
	expected at: 'Section' put: Dictionary new.
	expected at: 'Section' at: 'key' put: 'value'.
	expected at: 'Section2' put: Dictionary new.
	expected at: 'Section2' at: 'key' put: 'value'.
	expected at: 'Section2' at: 'anotherKey' put: 'value'.
	expected at: 'Section 3' put: Dictionary new.
	expected at: 'Section 3' at: 'key' put: 'value'.

	self assert: v equals: expected
]
