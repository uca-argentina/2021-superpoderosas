Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Dice class >> newDiceWithNFaces: aNumberOfFaces [ 
	^self new initializeWith: aNumberOfFaces.
]

{ #category : #characterizing }
Dice >> hasNFaces: aNumberOfFaces [ 
	^ (aNumberOfFaces = numberOfFaces).
]

{ #category : #initalize }
Dice >> initializeWith: aNumberOfFaces [  
	numberOfFaces:= aNumberOfFaces.
]

{ #category : #actions }
Dice >> throw [
	self shouldBeImplemented.
]
