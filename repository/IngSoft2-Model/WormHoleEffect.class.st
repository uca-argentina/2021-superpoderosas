Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHoleEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	| newPosition auxiliarFieldNumber |
	auxiliarFieldNumber := (aPosition  field asInteger) - 4.
	"hacer extract method"
	newPosition:= Position 
		determinedMainlyBy: 
			((aPosition round ~= 1 & (auxiliarFieldNumber <= 0)) ifTrue: [ (aPosition round asInteger) - 1  ] ifFalse:[aPosition round])
		andSecondlyBy:
			((aPosition round ~= 1 & (auxiliarFieldNumber <= 0)) ifTrue: [ aNumberOfFields + (auxiliarFieldNumber) ] ifFalse:[(1 max: auxiliarFieldNumber)])
		has: 
			(aPosition player).
	self at: playersPosition replace: aPosition with: newPosition.
]
