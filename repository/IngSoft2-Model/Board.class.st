Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'amountOfFields'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> withAnAmountOfFields: anAmountOfFields [
	^ self new initializeWith: anAmountOfFields .
]

{ #category : #characterizing }
Board >> amountOfFields [
	^ amountOfFields
]

{ #category : #initialize }
Board >> initializeWith: anAmountOfFields [ 
	amountOfFields:= anAmountOfFields .
]
