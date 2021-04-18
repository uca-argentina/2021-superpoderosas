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

{ #category : #initialize }
DiceCup >> initializeContaining: aGroupOfDices [  
	dices:= aGroupOfDices.
]

{ #category : #actions }
DiceCup >> throw [
	| resultOfThrowingAGroupOfDices |
	resultOfThrowingAGroupOfDices :=0.
	dices do: [ :aDice | resultOfThrowingAGroupOfDices := resultOfThrowingAGroupOfDices + (aDice throw) ].
	^resultOfThrowingAGroupOfDices.
]
