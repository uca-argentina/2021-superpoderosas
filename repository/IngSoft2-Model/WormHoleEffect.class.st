Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHoleEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	| newPosition |
	newPosition:= Position determinedMainlyBy: (1 max: ((aPosition round)-((1 max:(aPosition field - 4)) // aNumberOfFields))) andSecondlyBy:((1 max:(aPosition field - 4)) % aNumberOfFields) has: (aPosition player).	
	playersPosition remove: aPosition.
	playersPosition add: newPosition.
]
