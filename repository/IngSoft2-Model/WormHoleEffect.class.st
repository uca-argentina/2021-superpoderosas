Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHoleEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	| newPosition auxiliarFieldNumber |
	"newPosition:= Position determinedMainlyBy: (aPosition round + ((aPosition field - 4) // aNumberOfFields)) andSecondlyBy: ((aPosition field + 4) % aNumberOfFields) has: (aPosition player)."
	auxiliarFieldNumber := aPosition  field - 4.
	newPosition:= Position 
		determinedMainlyBy: 
			(1 max: ((aPosition round)-((1 max: auxiliarFieldNumber) // aNumberOfFields))) 
		andSecondlyBy:
			( aPosition round ~= 1 & (auxiliarFieldNumber <= 0) ifTrue: [ ^(aNumberOfFields - (aPosition - 4)) ] ifFalse:[(1 max: auxiliarFieldNumber)])
		has: 
			(aPosition player).
	playersPosition remove: aPosition.
	playersPosition add: newPosition.
]
