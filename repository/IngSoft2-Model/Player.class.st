Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Player class >> called: aName [
	^ self new initializeWith: aName.
]

{ #category : #initialize }
Player >> initializeWith: aName [
	name:= aName.
]

{ #category : #actions }
Player >> isYourTurnToPlayWith: aGroupOfDices [
	| resultOfThrowingAGroupOfDices |
	resultOfThrowingAGroupOfDices :=0.
	aGroupOfDices do: [ :aDice | resultOfThrowingAGroupOfDices := resultOfThrowingAGroupOfDices + (self throws: aDice) ].
	^ resultOfThrowingAGroupOfDices.


]

{ #category : #characterizing }
Player >> name [
  ^ name
]

{ #category : #actions }
Player >> throws: aDice [ 
	^ aDice throw.
	
]
