Class {
	#name : #DiceCup,
	#superclass : #Dice,
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
DiceCup class >> errorMessageMustHaveAtLeastOneDice [
	^ 'A dice cup must contain at leaste ONE dice'
]

{ #category : #initialize }
DiceCup >> initializeContaining: aGroupOfDices [  
	self verifyIsNotEmpty: aGroupOfDices.
	dices:= aGroupOfDices.
]

{ #category : #accessing }
DiceCup >> numberOfDices [
	^ dices size.
]

{ #category : #actions }
DiceCup >> throw [
	| resultOfThrowingAGroupOfDices |
	resultOfThrowingAGroupOfDices :=0.
	dices do: [ :aDice | resultOfThrowingAGroupOfDices := resultOfThrowingAGroupOfDices + (aDice throw) ].
	^resultOfThrowingAGroupOfDices.
]

{ #category : #validations }
DiceCup >> verifyIsNotEmpty: aGroupOfDices [
	(aGroupOfDices  isEmpty ) 
		ifTrue: [ Error signal: (self class) errorMessageMustHaveAtLeastOneDice ] .
]
