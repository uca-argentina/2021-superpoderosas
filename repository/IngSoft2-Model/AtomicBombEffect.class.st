Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBombEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [
	(self determineRangeFromOneToSizeOf: playersPosition)
		with: playersPosition
		do: [ :index :position | 
			self
				at: playersPosition
				replaceWhereIndexIs: index
				withNewPositionBasedOn: position ]
]

{ #category : #private }
AtomicBombEffect >> at: playersPosition replaceWhereIndexIs: index withNewPositionBasedOn: position [
	^ playersPosition
		at: index
		put:
			(Position
				determinedMainlyBy: position round
				andSecondlyBy: 1
				has: position player)
]
