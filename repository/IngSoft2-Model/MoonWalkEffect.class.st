Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
MoonWalkEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	| auxiliarFieldNumber n auxiliarRoundNumber |
	n := (aPosition field) // 2.
	(self determineRangeFromOneToSizeOf: playersPosition) with: playersPosition
		do: [ :index :position | (position ~= aPosition)
				ifTrue: [ 
					auxiliarFieldNumber := (position field asInteger) - n.
					auxiliarRoundNumber := (position round).
					playersPosition
						at: index
						put: (Position
						determinedMainlyBy: (self determineNewRoundBasingMainlyOn: auxiliarRoundNumber andSecondlyOn: auxiliarFieldNumber)
						andSecondlyBy: (self determineNewFieldBasingMainlyOn: auxiliarRoundNumber andSecondlyOn:auxiliarFieldNumber onABoardWith: aNumberOfFields )
						has: (position player) )] 
				].
					
]
