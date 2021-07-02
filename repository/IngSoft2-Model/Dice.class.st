Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Dice class >> having: aNumberOfFaces [. 
	^ self new initializeHaving: aNumberOfFaces.
]

{ #category : #'error messages' }
Dice >> errorMessageMustHaveAtLeastThreeFaces [
	^ 'A random dice must have at least three faces'
]

{ #category : #initialize }
Dice >> initializeHaving: aNumberOfFaces [  
	self verifyIfItHasAtLeastThreeFaces: aNumberOfFaces.
	numberOfFaces:= aNumberOfFaces.
]

{ #category : #actions }
Dice >> throw [
	^(1 to: numberOfFaces) atRandom.
]

{ #category : #validations }
Dice >> verifyIfItHasAtLeastThreeFaces: aNumberOfFaces [  
	(aNumberOfFaces < 3) 
		ifTrue: [ Error signal: self errorMessageMustHaveAtLeastThreeFaces ] .
]
