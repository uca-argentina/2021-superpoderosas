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
Sequence class >> newFrom: values [
	^ self new initializeNewFrom: values.
	
]

{ #category : #accessing }
Sequence >> actualElement [
	^ elements at: index.
]

{ #category : #private }
Sequence >> increaseIndex [
	index := index +1.
]

{ #category : #initialize }
Sequence >> initializeNewFrom: values [
	elements := values.
	index := 1.
]

{ #category : #accessing }
Sequence >> nextElement [
	| oldIndex |
	oldIndex := index.
	self updateIndex.
	^ elements at: oldIndex.
]

{ #category : #private }
Sequence >> replaceIndexWithTheOriginalOne [
	index := 1.
]

{ #category : #private }
Sequence >> updateIndex [
	(self verifyIfThePatternIndexHasToBeTheOriginal) 
		ifTrue:[self replaceIndexWithTheOriginalOne]
		ifFalse:[self increaseIndex]
]

{ #category : #validations }
Sequence >> verifyIfThePatternIndexHasToBeTheOriginal [
	^ index = elements size.
]
