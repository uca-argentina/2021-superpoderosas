Class {
	#name : #Sequence,
	#superclass : #Object,
	#instVars : [
		'index',
		'elements',
		'excludedElements'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Sequence class >> newFrom: elementsSequence [
	^ self new initializeNewFrom: elementsSequence.
	
]

{ #category : #accessing }
Sequence >> actualElement [
	^ elements at: index.
]

{ #category : #'error messages' }
Sequence >> errorMessageElementWasNeverExcluded [
	^ 'This element was never exclude, therefore it can not be reincorporated'
]

{ #category : #actions }
Sequence >> excludePermantly: anElement [
	excludedElements add: anElement.
]

{ #category : #initialize }
Sequence >> initializeNewFrom: elementsSequence [
	elements := elementsSequence.
	index := 1.
	excludedElements:= OrderedCollection new.
]

{ #category : #accessing }
Sequence >> nextElement [
	| oldIndex element |
	oldIndex := index.
	self renovateIndex.
	element := elements at: oldIndex.
	^self nextElementConsideringPossibleExclusionOf: element.
]

{ #category : #private }
Sequence >> nextElementConsideringPossibleExclusionOf: element [
	(self validateIsNotExclude: element)
		ifTrue: [ ^ self nextElement ]
		ifFalse: [ ^ element ]
]

{ #category : #actions }
Sequence >> reincorporate: anElement [
	excludedElements
		remove: anElement
		ifAbsent:
			[ Error signal: self errorMessageElementWasNeverExcluded ]
]

{ #category : #private }
Sequence >> renovateIndex [
	self verifyIfThePatternIndexHasToBeTheOriginal
		ifTrue: [ self replaceIndexWithTheOriginalOne ]
		ifFalse: [ self updateIndex ]
]

{ #category : #private }
Sequence >> replaceIndexWithTheOriginalOne [
	index := 1.
]

{ #category : #private }
Sequence >> updateIndex [
	index := index + 1.
]

{ #category : #validations }
Sequence >> validateIsNotExclude: anElement [
	^ excludedElements contains: [:element | anElement = element].
]

{ #category : #validations }
Sequence >> verifyIfThePatternIndexHasToBeTheOriginal [
	^ index >= (elements size).
]
