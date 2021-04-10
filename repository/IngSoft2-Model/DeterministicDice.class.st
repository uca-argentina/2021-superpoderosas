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
DeterministicDice class >> newDiceWithNFaces: aNumberOfFaces  andPattern: aPattern [. 
	^self new initializeWith: aNumberOfFaces and: aPattern.
]

{ #category : #actions }
DeterministicDice >> incrementByOnePatternIndexBasedOnTimesThrown [
	^patterIndexBasedOnTimesThrown+1.
]

{ #category : #initialize }
DeterministicDice >> initializeWith: aNumberOfFaces  and: aPattern [ 
	super  initializeWith: aNumberOfFaces.
	pattern:= aPattern.
	patterIndexBasedOnTimesThrown:=0.
]

{ #category : #actions }
DeterministicDice >> resetPatterIndexBasenOnTimesThrown [
	^1.
]

{ #category : #actions }
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

{ #category : #actions }
DeterministicDice >> verifyIfThePatternIndexhasReachedTheLimit [
	^patterIndexBasedOnTimesThrown == (pattern size)
]
