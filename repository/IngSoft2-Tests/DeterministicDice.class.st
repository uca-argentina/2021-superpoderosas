Class {
	#name : #DeterministicDice,
	#superclass : #Dice,
	#instVars : [
		'pattern',
		'patternIndex'
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
	patternIndex := SequenceSimulator newFrom: (aPattern size).
]

{ #category : #actions }
DeterministicDice >> throw [
	^ pattern at: (patternIndex nextIndex).
	
	
	
]
