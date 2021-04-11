Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'actualPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Player class >> called: aName [
	^ self new initializeWith: aName.
]

{ #category : #characterizing }
Player >> actualPosition [
	^ actualPosition.
]

{ #category : #initialize }
Player >> initializeWith: aName [
	name:= aName.
	actualPosition := 0.
]

{ #category : #actions }
Player >> isYourTurnToPlayWith: aGroupOfDices [
	| resultOfThrowingAGroupOfDices |
	resultOfThrowingAGroupOfDices :=0.
	aGroupOfDices do: [ :aDice | resultOfThrowingAGroupOfDices := resultOfThrowingAGroupOfDices + (self throws: aDice) ].
	self updatePosition: resultOfThrowingAGroupOfDices.

]

{ #category : #characterizing }
Player >> name [
  ^ name
]

{ #category : #actions }
Player >> reportNameAndActualPosition [
	^ name,': ',(actualPosition asString).
]

{ #category : #actions }
Player >> throws: aDice [ 
	^ aDice throw.
	
]

{ #category : #actions }
Player >> updatePosition: aResultOfThrowingADice [
	actualPosition := actualPosition + aResultOfThrowingADice.
]
