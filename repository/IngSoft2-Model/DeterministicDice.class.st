Class {
	#name : #DeterministicDice,
	#superclass : #Dice,
	#instVars : [
		'pattern',
		'patterIndexBasedOnTimesThrown'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DeterministicDice class >> with: aPattern [. 
	^self new initializeWith: aPattern.
]

{ #category : #private }
DeterministicDice >> incrementByOnePatternIndexBasedOnTimesThrown [
	^patterIndexBasedOnTimesThrown+1.
]

{ #category : #initialize }
DeterministicDice >> initializeWith: aPattern [ 
	pattern:= aPattern.
	patterIndexBasedOnTimesThrown:=0.
]

{ #category : #private }
DeterministicDice >> resetPatterIndexBasenOnTimesThrown [
	^1.
]

{ #category : #private }
DeterministicDice >> returnUpdatedPatterIndexBasenOnTimesThrown [
	(self verifyIfThePatternIndexhasReachedTheLimit) 
		ifTrue:[^self resetPatterIndexBasenOnTimesThrown]
		ifFalse:[^ (self incrementByOnePatternIndexBasedOnTimesThrown)].
]

{ #category : #actions }
DeterministicDice >> throw [
	patterIndexBasedOnTimesThrown:= self returnUpdatedPatterIndexBasenOnTimesThrown.
	^ pattern at: patterIndexBasedOnTimesThrown.
	
	
	
]

{ #category : #private }
DeterministicDice >> verifyIfThePatternIndexhasReachedTheLimit [
	^patterIndexBasedOnTimesThrown == (pattern size)
]
