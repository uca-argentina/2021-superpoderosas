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
	^ self new initializeCalled: aNumberOfFaces.
]

{ #category : #accessing }
RandomDice >> hasNFaces: aNumberOfFaces [ 
	^ (aNumberOfFaces = numberOfFaces).
]

{ #category : #initialize }
RandomDice >> initializeCalled: aNumberOfFaces [  
	numberOfFaces:= aNumberOfFaces max:2.
]

{ #category : #actions }
RandomDice >> throw [
	^(1 to: numberOfFaces) atRandom.
]
