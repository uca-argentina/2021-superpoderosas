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
