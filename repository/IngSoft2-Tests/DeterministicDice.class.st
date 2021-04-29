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
	patternIndex := 0.
]

{ #category : #private }
DeterministicDice >> nextPatternIndex [
	(self verifyIfThePatternIndexHasToBeTheOriginal) 
		ifTrue:[^self originalPatternIndex]
		ifFalse:[^ (self updatePatternIndex)].
]

{ #category : #private }
DeterministicDice >> originalPatternIndex [
	^ 1.
]

{ #category : #actions }
DeterministicDice >> throw [
	patternIndex:= self nextPatternIndex.
	^ pattern at: patternIndex.
	
	
	
]

{ #category : #private }
DeterministicDice >> updatePatternIndex [
	^ patternIndex + 1.
]

{ #category : #private }
DeterministicDice >> verifyIfThePatternIndexHasToBeTheOriginal [
	^ patternIndex == (pattern size)
]
