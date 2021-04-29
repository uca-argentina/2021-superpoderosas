Class {
	#name : #DeterministicDice,
	#superclass : #Dice,
	#instVars : [
		'pattern',
		'patternIndexBasedOnTimesThrown'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DeterministicDice class >> with: aPattern [. 
	^ self new initializeWith: aPattern.
]

{ #category : #private }
DeterministicDice >> incrementByOnePatternIndexBasedOnTimesThrown [
	^ patternIndexBasedOnTimesThrown + 1.
]

{ #category : #initialize }
DeterministicDice >> initializeWith: aPattern [ 
	pattern := aPattern.
	patternIndexBasedOnTimesThrown := 0.
]

{ #category : #private }
DeterministicDice >> nextValueIndex [
	(self verifyIfThePatternIndexhasReachedTheLimit) 
		ifTrue:[^self resetPatternIndexBasenOnTimesThrown]
		ifFalse:[^ (self incrementByOnePatternIndexBasedOnTimesThrown)].
]

{ #category : #private }
DeterministicDice >> resetPatternIndexBasenOnTimesThrown [
	^ 1.
]

{ #category : #actions }
DeterministicDice >> throw [
	patternIndexBasedOnTimesThrown:= self nextValueIndex.
	^ pattern at: patternIndexBasedOnTimesThrown.
	
	
	
]

{ #category : #private }
DeterministicDice >> verifyIfThePatternIndexhasReachedTheLimit [
	^ patternIndexBasedOnTimesThrown == (pattern size)
]
