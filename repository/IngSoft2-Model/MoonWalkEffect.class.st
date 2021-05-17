Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
MoonWalkEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	| auxiliarFieldNumber n|
	n := (aPosition field) // 2.
	(1 to: playersPosition size)
		with: playersPosition
		do: [ :index :position | 
			position ~= aPosition
				ifTrue: [ 
					auxiliarFieldNumber := (position  field asInteger) - n.
					playersPosition
						at: index
						put:
							(Position 
								determinedMainlyBy: 
											((position round ~= 1 & (auxiliarFieldNumber <= 0)) ifTrue: [ (position round asInteger) - 1  ] ifFalse:[position round])
								andSecondlyBy:
											((position round ~= 1 & (auxiliarFieldNumber <= 0)) ifTrue: [ aNumberOfFields + (auxiliarFieldNumber) ] ifFalse:[(1 max: auxiliarFieldNumber)])
								has: (position player) )] ].
					
]
