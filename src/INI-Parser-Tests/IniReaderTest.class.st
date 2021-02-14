Class {
	#name : #IniReaderTest,
	#superclass : #TestCase,
	#category : #'INI-Parser-Tests'
}

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
	r := IniReader on: ('[Section]',Character lf asString , 'key = value', Character lf asString, '[Section2]',Character lf asString,'key = value') readStream .
	v := r parse .
	
	expected := Dictionary new.
	expected at: 'Section' put: Dictionary new.
	expected at: 'Section' at: 'key' put: 'value'.
	expected at: 'Section2' put: Dictionary new.
	expected at: 'Section2' at: 'key' put: 'value'.

	self assert: v equals: expected .
]

{ #category : #tests }
IniReaderTest >> testparseKeyValuePair [
	| r v |	
		
	r := IniReader on: 'key=value' readStream .
	v := r parseKeyValuePair .
	self assert: v equals: { 'key'. 'value' } .
	
	r := IniReader on: 'key with spaces=value' readStream .
	v := r parseKeyValuePair .
	self assert: v equals: { 'key with spaces'. 'value' } .
	
	r := IniReader on: 'key = value' readStream .
	v := r parseKeyValuePair .
	self assert: v equals: { 'key'. 'value' } .
	
	r := IniReader on: 'key = value value two value' readStream .
	v := r parseKeyValuePair .
	self assert: v equals: { 'key'. 'value value two value' } .
	
	r := IniReader on: 'key = value := value = value' readStream .
	v := r parseKeyValuePair .
	self assert: v equals: { 'key'. 'value := value = value' } .
	
	r := IniReader on: 'key: value' readStream .
	r keyValueSeparator: $:.
	v := r parseKeyValuePair .
	self assert: v equals: { 'key'. 'value' } .
]
