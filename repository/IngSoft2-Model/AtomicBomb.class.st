Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBomb >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [
	(self determineRangeFromOneToSizeOf: playersPosition)
		with: playersPosition
		do: [ :index :position | 
			self
				at: playersPosition
				replaceWhereIndexIs: index
				withNewPositionBasedOn: position ]
]

{ #category : #private }
AtomicBomb >> at: playersPosition replaceWhereIndexIs: index withNewPositionBasedOn: position [
	^ playersPosition
		at: index
		put: (Position of: position player standingOn: 1 after: position round)
]
