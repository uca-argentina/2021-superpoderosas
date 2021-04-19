Class {
	#name : #RandomDice,
	#superclass : #Dice,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomDice class >> with: aNumberOfFaces [. 
	^ self new initializeWith: aNumberOfFaces.
]

{ #category : #characterizing }
RandomDice >> hasNFaces: aNumberOfFaces [ 
	^ (aNumberOfFaces = numberOfFaces).
]

{ #category : #initialize }
RandomDice >> initializeWith: aNumberOfFaces [  
	numberOfFaces:= aNumberOfFaces.
]

{ #category : #actions }
RandomDice >> throw [
	^(1 to: numberOfFaces) atRandom.
]
