Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
MoonWalk >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [
	| auxiliarFieldNumber n auxiliarRoundNumber |
	n := aPosition field // 2.
	(self determineRangeFromOneToSizeOf: playersPosition)
		with: playersPosition
		do: [ :index :position | 
			position ~= aPosition
				ifTrue: [ auxiliarFieldNumber := position field asInteger - n.
					auxiliarRoundNumber := position round.
					playersPosition
						at: index
						put:
							(Position
								of: position player
								standingOn:
									(self
										determineNewFieldBasingMainlyOn: auxiliarRoundNumber
										andSecondlyOn: auxiliarFieldNumber
										onABoardWith: aNumberOfFields)
								after:
									(self
										determineNewRoundBasingMainlyOn: auxiliarRoundNumber
										andSecondlyOn: auxiliarFieldNumber)) ] ]
]

{ #category : #actions }
MoonWalk >> applyTheEffectOn: aPosition of: aBoardGame [
	| n |
	n := (aPosition field) //2.
	aBoardGame moveAllPlayers: (n negated) exceptThePlayerOf: aPosition.
]
