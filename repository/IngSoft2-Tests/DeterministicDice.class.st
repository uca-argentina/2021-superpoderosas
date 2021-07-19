Class {
	#name : #DeterministicDice,
	#superclass : #Object,
	#instVars : [
		'pattern'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
DeterministicDice class >> with: aPattern [. 
	^ self new initializeWith: aPattern.
]

{ #category : #initialize }
DeterministicDice >> initializeWith: aPattern [ 
	pattern := Sequence newFrom: aPattern.
]

{ #category : #accessing }
DeterministicDice >> max [
	^ pattern  max.
]

{ #category : #actions }
DeterministicDice >> throw [
	^ pattern nextElement.
	
	
	
]
