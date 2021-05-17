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

{ #category : #initialize }
SequenceSimulator >> initializeNewFrom: aMaximun [
	max := aMaximun .
	index := 1.
]

{ #category : #accessing }
SequenceSimulator >> nextIndex [
	| oldIndex |
	oldIndex:= index.
	(self verifyIfThePatternIndexHasToBeTheOriginal) 
		ifTrue:[self originalPatternIndex]
		ifFalse:[self updatePatternIndex].
	^oldIndex.
]

{ #category : #private }
SequenceSimulator >> originalPatternIndex [
	index := 1.
]

{ #category : #private }
SequenceSimulator >> updatePatternIndex [
	index := index + 1.
]

{ #category : #private }
SequenceSimulator >> verifyIfThePatternIndexHasToBeTheOriginal [
	^ index = max.
]
