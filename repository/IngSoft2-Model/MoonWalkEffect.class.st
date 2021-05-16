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
	(1 to: playersPosition size)
		with: playersPosition
		do: [ :index :position | 
			position ~= aPosition
				ifTrue: [ playersPosition
						at: index
						put:
							(Position
								determinedMainlyBy: (1 max:(position round - ((1 max: (position field - n))//aNumberOfFields)))
								andSecondlyBy: ((1 max: (position field - n))%aNumberOfFields) 
								has: position player) ] ]
]

{ #category : #initialize }
MoonWalkEffect >> initializeAt: aField [
	n := aField // 2.
]
