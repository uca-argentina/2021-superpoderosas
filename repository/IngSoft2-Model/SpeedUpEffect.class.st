Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUpEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	| newPosition |
	newPosition:= Position determinedMainlyBy: (aPosition round + ((aPosition field + 4)// aNumberOfFields)) andSecondlyBy:((aPosition field + 4) % aNumberOfFields) has: (aPosition player).
	playersPosition remove: aPosition.
	playersPosition add: newPosition.
]
