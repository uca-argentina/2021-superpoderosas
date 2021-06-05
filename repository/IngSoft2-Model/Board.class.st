Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'fields'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> has: fields [ 
	^self new initializeHaving: fields.
]

{ #category : #initialization }
Board class >> of: aNumberOfFields [ 
	^ self new initializeOf: aNumberOfFields .
]

{ #category : #initialize }
Board >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [
	(self searchFieldFor: aPosition) applyTheEffectOn: aPosition of: self. 
]

{ #category : #initialize }
Board >> initializeHaving: someFields [ 
	fields := someFields .
]

{ #category : #accessing }
Board >> numberOfFields [
	 ^ fields size.
]

{ #category : #initialize }
Board >> searchFieldFor: aPosition [
	^ fields at: aPosition field
]
