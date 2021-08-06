Class {
	#name : #DeterministicDice,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'patternSequence'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
DeterministicDice class >> with: aPattern [. 
	^ self new initializeWith: aPattern.
]

{ #category : #initialize }
DeterministicDice >> initializeWith: aPattern [ 
	pattern := aPattern.
	patternSequence := Sequence newFrom: aPattern.
]

{ #category : #actions }
DeterministicDice >> throw [
	^ patternSequence nextElement.
	
	
	
]
