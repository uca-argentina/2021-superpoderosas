Class {
	#name : #RandomDice,
	#superclass : #Dice,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RandomDice class >> having: aNumberOfFaces [. 
	^ self new initializeHaving: aNumberOfFaces.
]

{ #category : #'error messages' }
RandomDice >> errorMessageMustHaveAtLeastThreeFaces [
	^ 'A random dice must have at least three faces'
]

{ #category : #initialize }
RandomDice >> initializeHaving: aNumberOfFaces [  
	self verifyIfItHasAtLeastThreeFaces: aNumberOfFaces.
	numberOfFaces:= aNumberOfFaces.
]

{ #category : #actions }
RandomDice >> throw [
	^(1 to: numberOfFaces) atRandom.
]

{ #category : #validations }
RandomDice >> verifyIfItHasAtLeastThreeFaces: aNumberOfFaces [  
	(aNumberOfFaces < 3) 
		ifTrue: [ Error signal: self errorMessageMustHaveAtLeastThreeFaces ] .
]
