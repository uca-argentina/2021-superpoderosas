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
	^self new initializeContaining: aGroupOfDices.
]

{ #category : #'error messages' }
DiceCup >> errorMessageMustHaveAtLeastOneDice [
	^ 'A dice cup must contain at leaste ONE dice'
]

{ #category : #initialize }
DiceCup >> initializeContaining: aGroupOfDices [  
	self verifyIfItIsNotEmpty: aGroupOfDices.
	dices:= aGroupOfDices.
]

{ #category : #actions }
DiceCup >> throw [
	| resultOfThrowingAGroupOfDices |
	resultOfThrowingAGroupOfDices :=0.
	dices do: [ :aDice | resultOfThrowingAGroupOfDices := resultOfThrowingAGroupOfDices + (aDice throw) ].
	^resultOfThrowingAGroupOfDices.
]

{ #category : #validations }
DiceCup >> verifyIfItIsNotEmpty: aGroupOfDices [
	(aGroupOfDices  isEmpty ) 
		ifTrue: [ Error signal: self errorMessageMustHaveAtLeastOneDice ] .
]
