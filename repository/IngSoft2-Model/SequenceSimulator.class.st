Class {
	#name : #SequenceSimulator,
	#superclass : #Object,
	#instVars : [
		'max',
		'index'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SequenceSimulator class >> newFrom: aMaximun [
	^ self new initializeNewFrom: aMaximun.
	
]

{ #category : #accessing }
SequenceSimulator >> actualIndex [
	^index.
]

{ #category : #accessing }
SequenceSimulator >> findNextIndex [
	| oldIndex |
	oldIndex:= index.
	(self verifyIfThePatternIndexHasToBeTheOriginal) 
		ifTrue:[self replaceIndexWithTheOriginalOne]
		ifFalse:[self updateIndex].
	^oldIndex.
]

{ #category : #initialize }
SequenceSimulator >> initializeNewFrom: aMaximun [
	max := aMaximun .
	index := 1.
]

{ #category : #private }
SequenceSimulator >> replaceIndexWithTheOriginalOne [
	index := 1.
]

{ #category : #private }
SequenceSimulator >> updateIndex [
	index := index + 1.
]

{ #category : #validations }
SequenceSimulator >> verifyIfThePatternIndexHasToBeTheOriginal [
	^ index = max.
]
