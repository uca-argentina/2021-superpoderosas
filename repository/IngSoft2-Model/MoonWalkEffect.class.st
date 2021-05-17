Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalkEffect class >> newAt: aField [
	^self new initializeAt: aField.
]

{ #category : #actions }
MoonWalkEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	| auxiliarFieldNumber |
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

{ #category : #initialize }
MoonWalkEffect >> initializeAt: aField [
	n := aField // 2.
]
