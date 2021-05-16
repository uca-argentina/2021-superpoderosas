Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBombEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	(1 to:(playersPosition  size)) with: playersPosition do: [:index :position| playersPosition at: index put: (Position determinedMainlyBy: position round andSecondlyBy: 1 has: position player)].
]
