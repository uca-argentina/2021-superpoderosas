Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'fields'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> size: aNumberOfFields [ 
	^ self new initializeSize: aNumberOfFields .
]

{ #category : #initialize }
Board >> applyEffectOn: playersPosition determinedBy: aPosition [ 
	(fields at: (aPosition field)) applyTheEffectOn: playersPosition determinedBy: aPosition .
	
	
	

	
]

{ #category : #initialize }
Board >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	(fields at: (aPosition field)) applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields .
	
	
	

	
]

{ #category : #initialize }
Board >> initializeSize: aNumberOfFields [ 
	fields := OrderedCollection new: aNumberOfFields withAll: NoEffect new.
	fields at: 3 put: WormHoleEffect new.
	fields at: 17 put: WormHoleEffect new.
	fields at: 30 put: SpeedUpEffect new.
	fields at: 44 put: AtomicBombEffect new.
	fields at: 32 put: (MoonWalkEffect newAt: 32).
	
	

	
]
