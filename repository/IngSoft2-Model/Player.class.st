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
	^ self new initializeCalled: aName.
]

{ #category : #accessing }
Player >> actualPosition [
	^ actualPosition.
]

{ #category : #initialize }
Player >> initializeCalled: aName [
	name:= aName.
	actualPosition := 0.
]

{ #category : #accessing }
Player >> name [
  ^ name
]

{ #category : #actions }
Player >> nameAndActualPosition [
	^ name,': ',(actualPosition asString).
]

{ #category : #actions }
Player >> throw: aDiceCup movingOn: aBoardGame [
	| resultOfThrowingAGroupOfDices |
	resultOfThrowingAGroupOfDices := aDiceCup throw.
	actualPosition := aBoardGame determinateNewPositionBasedOn: resultOfThrowingAGroupOfDices and: actualPosition.
	

]
