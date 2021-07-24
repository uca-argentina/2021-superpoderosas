Class {
	#name : #Sequence,
	#superclass : #Object,
	#instVars : [
		'index',
		'elements'
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

{ #category : #initialize }
Sequence >> initializeNewFrom: elementsSequence [ 
	elements := elementsSequence.
	index := 1.
]

{ #category : #accessing }
Sequence >> max [
	^elements max.
]

{ #category : #accessing }
Sequence >> nextElement [
	| oldIndex |
	oldIndex := index.
	self renovateIndex.
	^ elements at: oldIndex.
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
Sequence >> verifyIfThePatternIndexHasToBeTheOriginal [
	^ index >= (elements size).
]
