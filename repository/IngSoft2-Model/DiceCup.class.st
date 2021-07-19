Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dices'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DiceCup class >> containing: aGroupOfDices [ 
	self verifyIfThereIsAtLeastOnePlayerOn: aGroupOfDices.
	^self new initializeContaining: aGroupOfDices.
]

{ #category : #'error messages' }
DiceCup class >> errorMessageMustHaveAtLeastOneDice [
	^ 'A dice cup must contain at leaste ONE dice'
]

{ #category : #validations }
DiceCup class >> verifyIfThereIsAtLeastOnePlayerOn: aGroupOfDices [
	(aGroupOfDices  isEmpty ) 
		ifTrue: [ Error signal: self errorMessageMustHaveAtLeastOneDice ] .
]

{ #category : #initialize }
DiceCup >> initializeContaining: aGroupOfDices [  
	dices:= aGroupOfDices.
]

{ #category : #accesing }
DiceCup >> max [
	^dices sum:[:dice | dice max].
]

{ #category : #actions }
DiceCup >> throw [
	| resultOfThrowingAGroupOfDices |
	resultOfThrowingAGroupOfDices :=0.
	dices do: [ :aDice | resultOfThrowingAGroupOfDices := resultOfThrowingAGroupOfDices + (aDice throw) ].
	^resultOfThrowingAGroupOfDices.
]
