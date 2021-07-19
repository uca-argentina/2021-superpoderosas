Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'error messages' }
Dice class >> errorMessageMustHaveAtLeastThreeFaces [
	^ 'A random dice must have at least three faces'
]

{ #category : #initialization }
Dice class >> having: aNumberOfFaces [. 
	self verifyIfItHasAtLeastThreeFaces: aNumberOfFaces.
	^ self new initializeHaving: aNumberOfFaces.
]

{ #category : #validations }
Dice class >> verifyIfItHasAtLeastThreeFaces: aNumberOfFaces [  
	(aNumberOfFaces < 3) 
		ifTrue: [ Error signal: self errorMessageMustHaveAtLeastThreeFaces ] .
]

{ #category : #initialize }
Dice >> initializeHaving: aNumberOfFaces [  
	numberOfFaces:= aNumberOfFaces.
]

{ #category : #accesing }
Dice >> max [
	^numberOfFaces
]

{ #category : #actions }
Dice >> throw [
	^(1 to: numberOfFaces) atRandom.
]
