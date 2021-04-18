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
Player >> isYourTurnToThrow: aDiceCup andMoveAlong: aBoardGame [
	| resultOfThrowingAGroupOfDices |
	resultOfThrowingAGroupOfDices := aDiceCup throw.
	actualPosition := aBoardGame determinateNewPositionWith: resultOfThrowingAGroupOfDices and: self actualPosition.
	

]

{ #category : #characterizing }
Player >> name [
  ^ name
]

{ #category : #actions }
Player >> reportNameAndActualPosition [
	^ name,': ',(actualPosition asString).
]
